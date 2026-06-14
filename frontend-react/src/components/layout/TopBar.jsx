import { useState, useRef, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  Search, Bell, Menu, Settings, User, LogOut, ChevronDown,
  TrendingUp, ShieldCheck, BadgeCheck, Zap,
  MessageSquare, HelpCircle, Loader2, Sun, Moon, Monitor,
} from 'lucide-react';
import useAuthStore from '../../store/authStore';
import useUIStore from '../../store/uiStore';
import useNotificationStore from '../../store/notificationStore';
import useThemeStore from '../../store/themeStore';
import PandaLogo from '../ui/PandaLogo';
import { api } from '../../api';
import toast from 'react-hot-toast';

export default function TopBar() {
  const { user, logout, updateUser } = useAuthStore();
  const { toggleSidebar }            = useUIStore();
  const { unreadCount }              = useNotificationStore();
  const { theme, setTheme }          = useThemeStore();
  const navigate                     = useNavigate();

  const [searchQuery, setSearchQuery]       = useState('');
  const [profileOpen, setProfileOpen]       = useState(false);
  const [onlineForMsg, setOnlineForMsg]     = useState(user?.is_online ?? true);
  const [togglingOnline, setTogglingOnline] = useState(false);
  const profileRef  = useRef(null);
  const isFreelancer = user?.role === 'freelancer';

  useEffect(() => {
    if (user?.is_online !== undefined) setOnlineForMsg(!!user.is_online);
  }, [user?.is_online]);

  useEffect(() => {
    const handler = (e) => {
      if (profileRef.current && !profileRef.current.contains(e.target)) setProfileOpen(false);
    };
    document.addEventListener('mousedown', handler);
    return () => document.removeEventListener('mousedown', handler);
  }, []);

  const handleSearch = (e) => {
    e.preventDefault();
    if (searchQuery.trim()) {
      navigate(`/search?type=jobs&q=${encodeURIComponent(searchQuery.trim())}`);
      setSearchQuery('');
    }
  };

  const handleLogout = async () => {
    setProfileOpen(false);
    await logout();
    toast.success('Logged out successfully');
    navigate('/');
  };

  const go = (path) => { setProfileOpen(false); navigate(path); };

  const toggleOnline = async () => {
    const next = !onlineForMsg;
    setOnlineForMsg(next);
    setTogglingOnline(true);
    try {
      const res = await api.auth.updateProfile({ is_online: next });
      updateUser(res.data.user || {});
    } catch {
      setOnlineForMsg(!next);
      toast.error('Could not update online status');
    } finally {
      setTogglingOnline(false);
    }
  };

  const THEME_OPTIONS = [
    { value: 'light',  icon: Sun,     label: 'Light'  },
    { value: 'dark',   icon: Moon,    label: 'Dark'   },
    { value: 'system', icon: Monitor, label: 'System' },
  ];

  return (
    <header className="h-16 bg-dark-950/95 backdrop-blur-xl border-b border-dark-800/60 flex items-center px-4 gap-3 shrink-0 sticky top-0 z-40">

      {/* Sidebar toggle */}
      <button
        onClick={toggleSidebar}
        className="w-8 h-8 flex items-center justify-center rounded-lg text-dark-500 hover:text-dark-200 hover:bg-dark-800/70 transition-all shrink-0"
      >
        <Menu className="w-4 h-4" strokeWidth={2} />
      </button>

      {/* PANDA Logo */}
      <button
        onClick={() => navigate('/dashboard')}
        className="flex items-center gap-2 shrink-0 hover:opacity-80 transition-opacity"
        aria-label="Go to dashboard"
      >
        <PandaLogo className="w-7 h-7" />
        <span className="hidden md:block text-sm font-bold text-dark-100 tracking-wide">PANDA</span>
      </button>

      {/* Search bar */}
      <form onSubmit={handleSearch} className="flex-1 max-w-xl">
        <div className="relative flex items-center">
          <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-dark-500 pointer-events-none" strokeWidth={2} />
          <input
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            type="text"
            placeholder="Search jobs, freelancers, skills…"
            className="input pl-10 text-sm"
          />
        </div>
      </form>

      {/* Right actions */}
      <div className="flex items-center gap-1 ml-auto">

        {/* Messages */}
        <button
          onClick={() => navigate('/messages')}
          className="relative w-9 h-9 flex items-center justify-center rounded-xl text-dark-400 hover:text-dark-100 hover:bg-dark-800 transition-all"
          title="Messages"
        >
          <MessageSquare className="w-[18px] h-[18px]" strokeWidth={1.75} />
        </button>

        {/* Help */}
        <button
          className="w-9 h-9 flex items-center justify-center rounded-xl text-dark-400 hover:text-dark-100 hover:bg-dark-800 transition-all"
          title="Help"
        >
          <HelpCircle className="w-[18px] h-[18px]" strokeWidth={1.75} />
        </button>

        {/* Notifications */}
        <button
          className="relative w-9 h-9 flex items-center justify-center rounded-xl text-dark-400 hover:text-dark-100 hover:bg-dark-800 transition-all"
          title="Notifications"
        >
          <Bell className="w-[18px] h-[18px]" strokeWidth={1.75} />
          {unreadCount > 0 && (
            <span className="absolute top-1.5 right-1.5 min-w-[16px] h-4 px-1 bg-primary-500 rounded-full flex items-center justify-center text-[10px] font-bold text-white leading-none">
              {unreadCount > 9 ? '9+' : unreadCount}
            </span>
          )}
        </button>

        {/* Divider */}
        <div className="w-px h-6 bg-dark-800 mx-1" />

        {/* Profile dropdown */}
        <div className="relative" ref={profileRef}>
          <button
            onClick={() => setProfileOpen((v) => !v)}
            className="flex items-center gap-2 pl-1 pr-2 py-1 rounded-xl hover:bg-dark-800 transition-all"
          >
            <div className="relative shrink-0">
              <img
                src={user?.avatar_url || `https://ui-avatars.com/api/?name=${encodeURIComponent(user?.name || 'U')}&background=4361ff&color=fff&size=64`}
                alt={user?.name}
                className="w-8 h-8 rounded-full ring-1 ring-dark-700 object-cover"
              />
              {/* Online dot */}
              <span className={`absolute -bottom-0.5 -right-0.5 w-2.5 h-2.5 rounded-full border-2 border-dark-950 ${onlineForMsg ? 'bg-green-400' : 'bg-dark-600'}`} />
            </div>
            <div className="hidden sm:block text-left min-w-0">
              <div className="text-xs font-semibold text-dark-100 leading-tight truncate max-w-[80px]">{user?.name?.split(' ')[0]}</div>
              <div className="text-[10px] text-dark-500 capitalize leading-tight">{user?.role}</div>
            </div>
            <ChevronDown className={`hidden sm:block w-3 h-3 text-dark-600 shrink-0 transition-transform ${profileOpen ? 'rotate-180' : ''}`} />
          </button>

          <AnimatedDropdown open={profileOpen}>

            {/* ── Header: avatar + name ──────────────────────────── */}
            <div className="px-5 pt-5 pb-4 border-b border-dark-800/80">
              <div className="flex items-center gap-3.5">
                <div className="relative shrink-0">
                  <img
                    src={user?.avatar_url || `https://ui-avatars.com/api/?name=${encodeURIComponent(user?.name || 'U')}&background=4361ff&color=fff&size=128`}
                    alt={user?.name}
                    className="w-12 h-12 rounded-full object-cover ring-2 ring-dark-700"
                  />
                  <span className={`absolute -bottom-0.5 -right-0.5 w-3.5 h-3.5 rounded-full border-2 border-dark-900 transition-colors ${onlineForMsg ? 'bg-green-400' : 'bg-dark-600'}`} />
                </div>
                <div className="min-w-0 flex-1">
                  <div className="text-sm font-bold text-dark-50 truncate leading-tight">{user?.name}</div>
                  <div className="text-[11px] text-primary-400 capitalize font-medium mt-0.5">{user?.role}</div>
                  <div className="text-[10px] text-dark-500 truncate mt-0.5">{user?.email}</div>
                </div>
              </div>

              {/* Online toggle — inside header */}
              <div className="flex items-center justify-between mt-3.5 px-3 py-2 rounded-xl bg-dark-800/60">
                <div className="flex items-center gap-2">
                  <span className={`w-2 h-2 rounded-full shrink-0 transition-colors ${onlineForMsg ? 'bg-green-400 shadow-[0_0_6px_rgba(74,222,128,0.6)]' : 'bg-dark-600'}`} />
                  <span className="text-xs text-dark-300 font-medium">Online for messages</span>
                </div>
                <button
                  type="button"
                  disabled={togglingOnline}
                  onClick={toggleOnline}
                  aria-label="Toggle online status"
                  className={`relative w-10 h-[22px] rounded-full transition-all duration-300 shrink-0 cursor-pointer disabled:opacity-50 ${onlineForMsg ? 'bg-green-500' : 'bg-dark-600'}`}
                >
                  {togglingOnline
                    ? <Loader2 className="absolute inset-0 m-auto w-3.5 h-3.5 text-white animate-spin" />
                    : <span className={`absolute top-[3px] w-4 h-4 rounded-full bg-white shadow-md transition-all duration-300 ${onlineForMsg ? 'translate-x-[22px]' : 'translate-x-[3px]'}`} />
                  }
                </button>
              </div>
            </div>

            {/* ── Nav items ──────────────────────────────────────── */}
            <div className="py-2">
              <MenuSection>
                <MenuItem icon={User}        label="Your profile"     onClick={() => go(isFreelancer ? '/freelancer/profile' : '/settings')} />
                {isFreelancer && <MenuItem icon={TrendingUp} label="Stats and trends" onClick={() => go('/reports')} />}
                <MenuItem icon={ShieldCheck} label="Account health"   onClick={() => go('/account-health')} />
                <MenuItem icon={BadgeCheck}  label="Membership plan"  onClick={() => go('/membership')} />
                {isFreelancer && (
                  <button
                    type="button"
                    onClick={() => go('/connects')}
                    className="w-full flex items-center gap-3 px-4 py-2.5 text-sm text-dark-300 hover:text-dark-50 hover:bg-dark-800/80 transition-all rounded-lg mx-1 cursor-pointer group"
                    style={{ width: 'calc(100% - 8px)' }}
                  >
                    <span className="w-7 h-7 rounded-lg bg-dark-800 group-hover:bg-dark-700 flex items-center justify-center shrink-0 transition-colors">
                      <Zap className="w-3.5 h-3.5 text-yellow-400" strokeWidth={1.75} />
                    </span>
                    <span className="flex-1 text-left font-medium">Connects</span>
                    <span className="text-xs font-semibold px-2 py-0.5 rounded-full bg-primary-500/15 text-primary-400">
                      {user?.connects_balance ?? 0} left
                    </span>
                  </button>
                )}
              </MenuSection>

              {/* Theme picker */}
              <div className="mx-3 my-1 px-3 py-2.5 rounded-xl bg-dark-800/40">
                <div className="flex items-center justify-between mb-2">
                  <span className="text-[11px] font-semibold text-dark-400 uppercase tracking-wider">Theme</span>
                  <span className="text-[11px] text-primary-400 font-medium capitalize">{theme}</span>
                </div>
                <div className="flex gap-1.5">
                  {THEME_OPTIONS.map(({ value, icon: Icon, label }) => (
                    <button
                      key={value}
                      type="button"
                      onClick={() => setTheme(value)}
                      title={label}
                      className={`flex-1 flex items-center justify-center gap-1.5 py-1.5 rounded-lg text-xs font-medium transition-all cursor-pointer ${
                        theme === value
                          ? 'bg-primary-500 text-white shadow-sm'
                          : 'text-dark-400 hover:text-dark-100 hover:bg-dark-700'
                      }`}
                    >
                      <Icon className="w-3.5 h-3.5" strokeWidth={1.75} />
                      {label}
                    </button>
                  ))}
                </div>
              </div>

              <MenuSection className="border-t border-dark-800/80 mt-2 pt-2">
                <MenuItem icon={Settings} label="Account settings" onClick={() => go('/settings')} />
              </MenuSection>
            </div>

            {/* ── Logout ─────────────────────────────────────────── */}
            <div className="px-3 pb-3 border-t border-dark-800/80 pt-2">
              <button
                type="button"
                onClick={handleLogout}
                className="w-full flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm text-dark-400 hover:text-red-400 hover:bg-red-500/10 transition-all cursor-pointer group"
              >
                <span className="w-7 h-7 rounded-lg bg-dark-800 group-hover:bg-red-500/10 flex items-center justify-center shrink-0 transition-colors">
                  <LogOut className="w-3.5 h-3.5" strokeWidth={1.75} />
                </span>
                <span className="font-medium">Log out</span>
              </button>
            </div>

          </AnimatedDropdown>
        </div>
      </div>
    </header>
  );
}

function MenuItem({ icon: Icon, label, onClick, badge }) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="w-full flex items-center gap-3 px-4 py-2.5 text-sm text-dark-300 hover:text-dark-50 hover:bg-dark-800/80 transition-all rounded-lg mx-1 cursor-pointer group"
      style={{ width: 'calc(100% - 8px)' }}
    >
      <span className="w-7 h-7 rounded-lg bg-dark-800 group-hover:bg-dark-700 flex items-center justify-center shrink-0 transition-colors">
        <Icon className="w-3.5 h-3.5 text-dark-400 group-hover:text-dark-200" strokeWidth={1.75} />
      </span>
      <span className="flex-1 text-left font-medium">{label}</span>
      {badge && <span className="text-[10px] font-semibold px-1.5 py-0.5 rounded-full bg-primary-500/15 text-primary-400">{badge}</span>}
    </button>
  );
}

function MenuSection({ children, className = '' }) {
  return <div className={`px-2 ${className}`}>{children}</div>;
}

function AnimatedDropdown({ open, children }) {
  if (!open) return null;
  return (
    <div className="absolute right-0 top-full mt-2 w-72 rounded-2xl border border-dark-800/80 bg-dark-900 shadow-[0_8px_32px_rgba(0,0,0,0.4)] z-50 overflow-hidden animate-scale-in">
      {children}
    </div>
  );
}
