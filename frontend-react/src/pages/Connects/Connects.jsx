import { useState } from 'react';
import { Zap, Search } from 'lucide-react';
import useAuthStore from '../../store/authStore';

const TYPES = ['All connects', 'Earned', 'Purchased', 'Used', 'Refunded'];
const DATES = ['Last 7 days', 'Last 30 days', 'Last 3 months', 'Last year'];

export default function Connects() {
  const { user } = useAuthStore();
  const balance = user?.connects_balance ?? 0;
  const [type, setType] = useState('All connects');
  const [date, setDate] = useState('Last 7 days');

  return (
    <div className="p-6 max-w-5xl mx-auto">
      <h1 className="text-2xl font-bold theme-text mb-6">Connects History</h1>

      {/* Balance card */}
      <div className="card p-6 mb-6 flex items-center gap-6">
        <div className="flex-1">
          <p className="text-sm theme-muted mb-1">My balance</p>
          <p className="text-3xl font-bold theme-text">{balance} Connects</p>
          <button className="btn btn-primary text-sm px-5 py-2.5 mt-4">
            Buy Connects
          </button>
        </div>
        <div className="w-24 h-24 flex items-center justify-center rounded-full bg-primary-500/10 shrink-0">
          <Zap className="w-12 h-12 text-primary-400" strokeWidth={1.5} />
        </div>
      </div>

      {/* Filters */}
      <div className="card p-6">
        <div className="flex flex-wrap gap-3 mb-6">
          <div className="flex flex-col gap-1 flex-1 min-w-[160px]">
            <label className="text-xs theme-muted font-medium">Connects type</label>
            <select
              value={type}
              onChange={(e) => setType(e.target.value)}
              className="input text-sm"
            >
              {TYPES.map((t) => <option key={t}>{t}</option>)}
            </select>
          </div>
          <div className="flex flex-col gap-1 flex-1 min-w-[160px]">
            <label className="text-xs theme-muted font-medium">Date</label>
            <select
              value={date}
              onChange={(e) => setDate(e.target.value)}
              className="input text-sm"
            >
              {DATES.map((d) => <option key={d}>{d}</option>)}
            </select>
          </div>
        </div>

        {/* Empty state */}
        <div className="flex flex-col items-center py-16 text-center">
          <div className="w-20 h-20 rounded-full bg-dark-800 flex items-center justify-center mb-4">
            <Search className="w-9 h-9 text-dark-500" strokeWidth={1.5} />
          </div>
          <p className="font-semibold theme-text mb-1">No Connects transactions.</p>
          <p className="text-sm theme-muted">Try adjusting the filters</p>
        </div>
      </div>
    </div>
  );
}
