import { useState } from 'react';
import { ShieldCheck, CheckCircle, AlertTriangle } from 'lucide-react';

export default function AccountHealth() {
  const [tab, setTab] = useState('violations');

  return (
    <div className="p-6 max-w-5xl mx-auto">
      <h1 className="text-2xl font-bold theme-text mb-1">Account health</h1>
      <p className="text-sm theme-muted mb-8">
        Manage your account access and stay on track with PANDA's Trust &amp; Safety guidelines
      </p>

      {/* Top cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
        {/* Platform access */}
        <div className="card p-6 flex items-start justify-between gap-4">
          <div className="flex-1">
            <div className="flex items-center gap-2 mb-1">
              <h2 className="font-semibold theme-text">Platform access</h2>
              <span className="text-dark-500 text-sm cursor-help" title="Your current platform access level">?</span>
            </div>
            <p className="text-sm theme-muted mb-4">
              Your account currently has full platform access. Continue to follow Trust &amp; Safety
              policies to maintain uninterrupted access.
            </p>
            <button className="btn btn-primary text-sm px-4 py-2">
              Learn about our policies
            </button>
          </div>
          <div className="flex flex-col items-center gap-1 shrink-0">
            <div className="w-14 h-14 rounded-full bg-green-500/10 flex items-center justify-center ring-2 ring-green-500/30">
              <ShieldCheck className="w-7 h-7 text-green-400" strokeWidth={1.75} />
            </div>
            <span className="text-xs font-medium text-green-400">Full Access</span>
          </div>
        </div>

        {/* Account standing */}
        <div className="card p-6 flex items-start justify-between gap-4">
          <div className="flex-1">
            <div className="flex items-center gap-2 mb-1">
              <h2 className="font-semibold theme-text">Account standing</h2>
              <span className="text-dark-500 text-sm cursor-help" title="Your account standing score">?</span>
            </div>
            <p className="text-sm theme-muted">
              Based on your enforcement history, your account is in good standing and meets our
              guidelines. Continue following best practices to maintain your status and avoid future
              enforcement.
            </p>
          </div>
          {/* Gauge */}
          <div className="flex flex-col items-center gap-1 shrink-0">
            <div className="relative w-16 h-10 overflow-hidden">
              <div className="absolute bottom-0 left-1/2 -translate-x-1/2 w-16 h-16 rounded-full border-4 border-dark-700" />
              <div className="absolute bottom-0 left-1/2 -translate-x-1/2 w-16 h-16 rounded-full border-4 border-transparent border-l-yellow-400 border-b-green-400 rotate-[30deg]" />
              <div className="absolute bottom-0.5 left-1/2 -translate-x-1/2 w-0.5 h-6 bg-dark-200 origin-bottom rotate-[25deg]" />
            </div>
            <span className="text-xs font-medium text-green-400 mt-1">Good</span>
          </div>
        </div>
      </div>

      {/* Enforcement history */}
      <div className="card p-6">
        <h2 className="font-semibold theme-text mb-4">Enforcement history</h2>
        <div className="flex gap-6 border-b border-dark-800 mb-6">
          <button
            onClick={() => setTab('violations')}
            className={`pb-3 text-sm font-medium transition-colors border-b-2 ${
              tab === 'violations'
                ? 'border-primary-500 text-primary-400'
                : 'border-transparent theme-muted hover:theme-text'
            }`}
          >
            Policy violations <span className="ml-1 px-1.5 py-0.5 rounded-full bg-dark-800 text-xs">0</span>
          </button>
          <button
            onClick={() => setTab('appeals')}
            className={`pb-3 text-sm font-medium transition-colors border-b-2 ${
              tab === 'appeals'
                ? 'border-primary-500 text-primary-400'
                : 'border-transparent theme-muted hover:theme-text'
            }`}
          >
            Submitted appeals <span className="ml-1 px-1.5 py-0.5 rounded-full bg-dark-800 text-xs">0</span>
          </button>
        </div>

        <div className="flex flex-col items-center py-14 text-center">
          <div className="w-20 h-20 rounded-full bg-green-500/10 flex items-center justify-center mb-4">
            <CheckCircle className="w-10 h-10 text-green-400" strokeWidth={1.5} />
          </div>
          <p className="font-semibold theme-text mb-1">
            {tab === 'violations'
              ? "You don't have any policy violations."
              : "You don't have any submitted appeals."}
          </p>
          <p className="text-sm theme-muted">Thanks for following PANDA's guidelines.</p>
        </div>
      </div>
    </div>
  );
}
