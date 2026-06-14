import { Check } from 'lucide-react';
import useAuthStore from '../../store/authStore';

const BASIC_FEATURES = [
  'Send proposals to clients',
  'Build your freelancer profile',
  'Access to all job categories',
  'Basic project management tools',
  'Community support',
];

const PLUS_FEATURES = [
  'Everything in Basic',
  'Priority in search results',
  'Custom profile URL',
  '70 Connects per month',
  'See competitor bids',
  'Profile visibility boost',
  'Dedicated support',
];

export default function Membership() {
  const { user } = useAuthStore();
  const isPro = user?.subscription?.plan === 'pro';

  const cycleStart = new Date();
  const cycleEnd   = new Date(cycleStart);
  cycleEnd.setMonth(cycleEnd.getMonth() + 1);
  const fmt = (d) => d.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });

  return (
    <div className="p-6 max-w-4xl mx-auto">
      <h1 className="text-2xl font-bold theme-text mb-6">Membership</h1>

      {/* Plans */}
      <div className="card p-6 mb-4">
        <div className="flex items-center justify-between mb-6">
          <h2 className="font-semibold theme-text">Membership plan</h2>
          <button className="btn btn-primary text-sm px-4 py-2">Manage membership</button>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {/* Basic */}
          <div className={`relative rounded-2xl border-2 p-5 ${!isPro ? 'border-primary-500' : 'border-dark-700'}`}>
            {!isPro && (
              <span className="absolute -top-2.5 left-4 text-[10px] font-bold uppercase tracking-wider bg-dark-900 px-2 text-primary-400 border border-dark-700 rounded-full">
                Current plan
              </span>
            )}
            <h3 className="font-bold text-lg theme-text mb-0.5">Basic</h3>
            <p className="text-sm text-green-400 font-semibold mb-3">Free</p>
            <p className="text-sm theme-muted mb-4">Essential features to build your freelance career</p>
            <ul className="space-y-2">
              {BASIC_FEATURES.map((f) => (
                <li key={f} className="flex items-start gap-2 text-sm theme-muted">
                  <Check className="w-4 h-4 text-green-400 shrink-0 mt-0.5" strokeWidth={2.5} />
                  {f}
                </li>
              ))}
            </ul>
          </div>

          {/* Plus */}
          <div className={`relative rounded-2xl border-2 p-5 ${isPro ? 'border-primary-500' : 'border-dark-700'}`}>
            <span className="absolute -top-2.5 right-4 text-[10px] font-bold uppercase tracking-wider bg-primary-500 px-2 text-white rounded-full">
              Popular
            </span>
            {isPro && (
              <span className="absolute -top-2.5 left-4 text-[10px] font-bold uppercase tracking-wider bg-dark-900 px-2 text-primary-400 border border-dark-700 rounded-full">
                Current plan
              </span>
            )}
            <h3 className="font-bold text-lg theme-text mb-0.5">Plus</h3>
            <p className="text-sm theme-muted font-semibold mb-3">$19.99 <span className="text-xs">per month</span></p>
            <p className="text-sm theme-muted mb-4">Win more work with competitive tools</p>
            <ul className="space-y-2">
              {PLUS_FEATURES.map((f) => (
                <li key={f} className="flex items-start gap-2 text-sm theme-muted">
                  <Check className="w-4 h-4 text-primary-400 shrink-0 mt-0.5" strokeWidth={2.5} />
                  {f}
                </li>
              ))}
            </ul>
            {!isPro && (
              <button className="btn btn-primary w-full mt-5 text-sm">Upgrade to Plus</button>
            )}
          </div>
        </div>
      </div>

      {/* Membership cycle */}
      <div className="card p-6">
        <h2 className="font-semibold theme-text mb-3">Membership cycle</h2>
        <p className="text-sm theme-muted">{fmt(cycleStart)} – {fmt(cycleEnd)}</p>
      </div>
    </div>
  );
}
