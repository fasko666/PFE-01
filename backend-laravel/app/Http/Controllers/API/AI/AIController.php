<?php

namespace App\Http\Controllers\API\AI;

use App\Http\Controllers\Controller;
use App\Models\AiHistory;
use App\Models\JobPosting;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Http;

class AIController extends Controller
{
    private string $ollamaUrl;
    private string $defaultModel = 'tinyllama';

    public function __construct()
    {
        $this->ollamaUrl = config('services.ollama.url', 'http://localhost:11434');
    }

    public function generateProposal(Request $request): JsonResponse
    {
        $request->validate([
            'job_id'             => 'required|exists:job_postings,id',
            'freelancer_summary' => 'nullable|string',
        ]);

        $job = JobPosting::with('category')->findOrFail($request->job_id);
        $user = $request->user();
        $profile = $user->freelancerProfile;

        $prompt = $this->buildProposalPrompt($job, $profile, $request->freelancer_summary);

        $result = $this->callAI($prompt);

        AiHistory::create([
            'user_id'     => $user->id,
            'type'        => 'proposal',
            'input'       => ['job_id' => $job->id, 'job_title' => $job->title],
            'output'      => ['proposal' => $result],
            'model'       => $this->defaultModel,
            'tokens_used' => strlen($result) / 4,
        ]);

        return response()->json(['proposal' => $result]);
    }

    public function matchFreelancers(Request $request): JsonResponse
    {
        $request->validate(['job_id' => 'required|exists:job_postings,id']);

        $job = JobPosting::findOrFail($request->job_id);
        $skills = $job->skills ?? [];

        $freelancers = User::with(['freelancerProfile', 'skills'])
            ->where('role', 'freelancer')
            ->where('is_active', true)
            ->whereHas('skills', fn($q) => $q->whereIn('name', $skills))
            ->orderByDesc('created_at')
            ->limit(10)
            ->get();

        $scored = $freelancers->map(function ($f) use ($skills, $job) {
            $fSkills = $f->skills->pluck('name')->toArray();
            $match = count(array_intersect($fSkills, $skills));
            $total = max(count($skills), 1);
            $score = round(($match / $total) * 100);

            return [
                'user'          => $f,
                'match_score'   => $score,
                'matched_skills'=> array_intersect($fSkills, $skills),
            ];
        })->sortByDesc('match_score')->values();

        return response()->json(['matches' => $scored]);
    }

    public function chat(Request $request): JsonResponse
    {
        $request->validate(['message' => 'required|string|max:2000']);

        $systemPrompt = "You are PANDA AI, a helpful assistant for the PANDA freelance marketplace. You help freelancers find work, write proposals, improve their profiles, and help clients find the right talent. Be concise, professional, and helpful.";

        $result = $this->callAI($request->message, $systemPrompt);

        AiHistory::create([
            'user_id'     => $request->user()->id,
            'type'        => 'chat',
            'input'       => ['message' => $request->message],
            'output'      => ['response' => $result],
            'model'       => $this->defaultModel,
            'tokens_used' => (strlen($request->message) + strlen($result)) / 4,
        ]);

        return response()->json(['response' => $result]);
    }

    public function analyzeProfile(Request $request): JsonResponse
    {
        $user = $request->user()->load('freelancerProfile', 'skills', 'portfolios');
        $profile = $user->freelancerProfile;

        $prompt = "Analyze this freelancer profile and give specific improvement suggestions in JSON format with keys: 'score' (0-100), 'strengths' (array), 'weaknesses' (array), 'suggestions' (array of specific actions). Profile: Title: {$profile->title}, Bio: {$profile->bio}, Skills: " . $user->skills->pluck('name')->join(', ') . ", Hourly rate: \${$profile->hourly_rate}, Experience: {$profile->experience_level}";

        $result = $this->callAI($prompt);

        return response()->json(['analysis' => $result]);
    }

    public function smartSearch(Request $request): JsonResponse
    {
        $request->validate(['query' => 'required|string']);

        $q      = $request->input('query');
        $prompt = "Convert this job search query to structured search parameters in JSON format with keys: 'keywords' (array), 'skills' (array), 'budget_range' (object with min/max or null), 'experience_level' (entry/intermediate/expert or null), 'job_type' (hourly/fixed or null). Query: '{$q}'";

        $result = $this->callAI($prompt);

        return response()->json(['search_params' => $result]);
    }

    private function buildProposalPrompt(JobPosting $job, $profile, ?string $summary): string
    {
        return "Write a professional, compelling freelance proposal for this job. Be specific, personalized, and persuasive. Keep it under 400 words.

Job Title: {$job->title}
Description: " . substr($job->description, 0, 500) . "
Budget: " . ($job->budget_min ? "\${$job->budget_min} - \${$job->budget_max}" : 'Negotiable') . "
Type: {$job->type}

My Profile:
Title: " . ($profile->title ?? 'Freelancer') . "
Experience: " . ($profile->experience_level ?? 'intermediate') . "
Rate: \$" . ($profile->hourly_rate ?? '50') . "/hr
" . ($summary ? "Additional context: $summary" : '') . "

Write only the proposal text, no meta-commentary.";
    }

    private function callAI(string $prompt, string $system = ''): string
    {
        try {
            set_time_limit(150);
            $response = Http::timeout(120)->post("{$this->ollamaUrl}/api/generate", [
                'model'  => $this->defaultModel,
                'prompt' => ($system ? "System: $system\n\n" : '') . "User: $prompt",
                'stream' => false,
            ]);

            if ($response->successful()) {
                return $response->json('response', 'AI service temporarily unavailable. Please try again.');
            }
        } catch (\Exception $e) {
            // Fallback response if Ollama is not available
        }

        return $this->getFallbackResponse($prompt);
    }

    private function getFallbackResponse(string $prompt): string
    {
        $p = strtolower($prompt);

        // Proposal writing
        if (str_contains($p, 'proposal') && (str_contains($p, 'write') || str_contains($p, 'winning') || str_contains($p, 'react') || str_contains($p, 'develop'))) {
            return "Here's a winning proposal template you can adapt:\n\n---\n\nHi [Client Name],\n\nI just read through your job post and I'm genuinely excited about this project — it's exactly the kind of work I specialize in.\n\n**Why I'm the right fit:**\nI've spent the last 4+ years building production React applications, including SPAs, dashboards, and e-commerce platforms. I know how to write clean, maintainable code that scales.\n\n**My approach for your project:**\nI'd start with a quick discovery call to align on scope, then deliver an initial prototype within the first week so you can see real progress early. I work iteratively and keep you updated daily.\n\n**What you get:**\n- Clean, well-documented code\n- Mobile-responsive UI\n- Full testing coverage\n- Post-delivery support for 2 weeks\n\nI'm available to start immediately and can dedicate 40 hrs/week to this. Happy to share relevant portfolio samples.\n\nLooking forward to hearing from you!\n\n[Your Name]\n\n---\n\n**Tips to personalize this:**\n1. Replace the opening with a specific detail from *their* job post\n2. Mention one concrete past project that mirrors their needs\n3. Address their biggest concern directly (deadline, budget, technical stack)";
        }

        // Profile improvement
        if (str_contains($p, 'profile') && (str_contains($p, 'improve') || str_contains($p, 'optimize') || str_contains($p, 'attract') || str_contains($p, 'better'))) {
            return "Here are the highest-impact changes to improve your freelancer profile:\n\n**1. Headline (most important)**\nDon't say \"Web Developer\" — say \"React & Node.js Developer | 50+ SPAs Delivered | Fast Turnaround\". Be specific and results-focused.\n\n**2. Profile photo**\nA professional headshot increases response rates by ~40%. Good lighting, neutral background, genuine smile.\n\n**3. Overview / Bio**\nOpen with your specialization and a key result: *\"I help SaaS startups ship polished React frontends 2x faster by...\"*\nThen list your top 3 skills and your process. End with a call to action.\n\n**4. Portfolio**\nAdd at least 3 case studies. Each should include: the problem, your solution, and a measurable result (e.g. *\"reduced load time by 60%\"*).\n\n**5. Skills section**\nBe precise — \"React 18\" beats \"JavaScript\". Include niche skills that have less competition.\n\n**6. Hourly rate**\nIf you have 0 reviews, price 20% below market to land your first 3 jobs. Once you have reviews, raise it.\n\n**7. Availability badge**\nKeep \"Available\" status on — clients filter by this.\n\nWant me to review any specific section in more detail?";
        }

        // Rate / pricing
        if (str_contains($p, 'rate') || str_contains($p, 'charge') || str_contains($p, 'price') || str_contains($p, 'hourly')) {
            return "Here's how to set the right rate for senior web development:\n\n**Market benchmarks (2025):**\n- Entry level (0–2 yrs): \$25–\$45/hr\n- Mid-level (2–5 yrs): \$50–\$85/hr\n- Senior (5+ yrs): \$90–\$150/hr\n- Specialist/niche expert: \$120–\$200+/hr\n\n**How to find YOUR number:**\n1. Research 10 profiles similar to yours on the platform\n2. Start in the middle of the range, not the top\n3. If you're getting 3+ interviews per 10 proposals → raise rate 15%\n4. If you're getting 0 interviews → lower rate or improve profile first\n\n**Fixed-price vs hourly:**\n- Hourly: better for long-term, evolving projects\n- Fixed-price: better for defined deliverables — price 20% higher to buffer scope creep\n\n**Pro tip:** Quote your rate with confidence. Hesitation signals uncertainty. Clients who negotiate aggressively are usually the most demanding — it's okay to walk away.";
        }

        // Job description writing
        if (str_contains($p, 'job description') || str_contains($p, 'job post') || (str_contains($p, 'write') && str_contains($p, 'job'))) {
            return "Here's a high-converting job description template for a UI/UX Designer:\n\n---\n\n**UI/UX Designer for [Product Name] — Mobile & Web**\n\n**About the project:**\nWe're building [brief product description] for [target users]. We need a talented designer to create an intuitive, polished experience from wireframes to final specs.\n\n**What you'll do:**\n- Design user flows, wireframes, and high-fidelity mockups in Figma\n- Conduct user research and translate insights into design decisions\n- Create and maintain a design system\n- Collaborate closely with our dev team for implementation\n\n**You're a great fit if you:**\n- Have 3+ years of product design experience\n- Can share a portfolio with mobile and web case studies\n- Are comfortable with design systems (Figma components, tokens)\n- Communicate proactively and hit deadlines\n\n**Project details:**\n- Timeline: [X weeks]\n- Budget: \$[X]–\$[X]\n- Availability: [X hrs/week]\n\n**To apply:** Include 2 relevant portfolio samples and one sentence on your design process.\n\n---\n\n**Why this works:** Specific scope, clear requirements, and a defined application filter reduce irrelevant proposals by 70%.";
        }

        // Difficult clients
        if (str_contains($p, 'difficult') || str_contains($p, 'unresponsive') || str_contains($p, 'client') && str_contains($p, 'handle')) {
            return "How to professionally handle difficult or unresponsive clients:\n\n**Unresponsive clients:**\n1. Send a friendly follow-up after 48 hrs: *\"Just checking in — I want to make sure I have everything I need to keep moving. Let me know if you have questions!\"*\n2. After 5 days: *\"I'll pause work on [X] until I hear back to avoid building in the wrong direction.\"*\n3. After 2 weeks: send a formal project status update and note the impact on timeline\n\n**Scope creep:**\nAlways respond positively but firmly: *\"Happy to add that! That would be outside our current scope — I can add it as a change order for \$X or we can swap it for [existing feature]. What works best?\"*\nNever say \"no\" — say \"yes, and here's the cost.\"\n\n**Demanding / rude clients:**\n- Keep all communication in writing\n- Match their energy with calm professionalism — it de-escalates\n- If they cross a line: *\"I want us to work well together. I do my best work when communication is respectful. Can we reset?\"*\n- Know when to end the contract — a 1-star review from a toxic client is worth less than your time and sanity\n\n**Prevention (best strategy):**\n- Define scope, revisions, and communication expectations in the contract\n- Weekly check-ins keep clients engaged and reduce surprises";
        }

        // Winning more proposals / tips
        if (str_contains($p, 'win') || str_contains($p, 'tips') || str_contains($p, 'more proposal') || str_contains($p, 'get more')) {
            return "**7 actionable tips to win more freelance proposals:**\n\n**1. Apply within the first 2 hours**\nJobs posted recently get 3x more views. Early applications get seen before clients are overwhelmed.\n\n**2. Open with THEIR problem, not your credentials**\n❌ *\"I'm a developer with 5 years experience...\"*\n✅ *\"I noticed you need X — I've solved that exact problem for [similar client]...\"*\n\n**3. Keep it under 200 words**\nClients skim. A focused, confident 150-word proposal beats a 600-word essay every time.\n\n**4. Show, don't tell**\nInstead of *\"I'm reliable\"* — link to a relevant portfolio piece. Proof > claims.\n\n**5. Ask one smart question**\nEnd with a question that shows you've read the job carefully. It starts a conversation and signals genuine interest.\n\n**6. Match their tone**\nCasual job post → conversational reply. Formal post → professional tone. Mirroring builds rapport.\n\n**7. Follow up once**\nIf no response after 3 days: *\"Just following up on my proposal — happy to answer any questions or hop on a quick call.\"* One follow-up can double your response rate.\n\n**Mindset:** Proposals are a numbers game *and* a quality game. Aim for 5 strong proposals per week rather than 20 generic ones.";
        }

        // General freelancing / default
        return "Great question! Here are some key principles for freelancing success on PANDA:\n\n**Getting started:**\n- Complete your profile to 100% — it signals professionalism\n- Start with competitive rates to build reviews, then raise them\n- Apply to 3–5 jobs daily with personalized proposals\n\n**Growing your business:**\n- Deliver slightly more than promised — clients remember it\n- Ask for reviews after every successful project\n- Upsell maintenance/support packages to existing clients\n- Specialize in a niche rather than being a generalist\n\n**Managing work:**\n- Always use contracts and escrow — never work without payment protection\n- Set clear milestones so both sides know what \"done\" looks like\n- Communicate proactively — clients hate surprises\n\nIs there a specific area you'd like to go deeper on? I can help with proposals, pricing, profile optimization, client communication, or finding the right jobs.";
    }
}
