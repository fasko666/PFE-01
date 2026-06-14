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
            {/* User info */}
            <div className="px-4 py-3.5 border-b border-dark-800">
              <div className="flex items-center gap-3">
                <div className="relative shrink-0">
                  <img
                    src={user?.avatar_url || `https://ui-avatars.com/api/?name=${encodeURIComponent(user?.name || 'U')}&background=4361ff&color=fff&size=64`}
                    alt={user?.name}
                    className="w-10 h-10 rounded-full object-cover ring-1 ring-dark-700"
                  />
                  <span className={`absolute -bottom-0.5 -right-0.5 w-3 h-3 rounded-full border-2 border-dark-900 ${onlineForMsg ? 'bg-green-400' : 'bg-dark-600'}`} />
                </div>
                <div className="min-w-0">
                  <div className="text-sm font-semibold text-dark-100 truncate">{user?.name}</div>
                  <div className="text-xs text-dark-500 capitalize">{user?.role}</div>
                </div>
              </div>
            </div>

            {/* Online for messages toggle */}
            <div className="px-4 py-2.5 border-b border-dark-800">
              <div className="flex items-center justify-between gap-3">
                <div className="flex items-center gap-1.5">
                  <span className={`w-1.5 h-1.5 rounded-full shrink-0 ${onlineForMsg ? 'bg-green-400' : 'bg-dark-600'}`} />
                  <span className="text-xs text-dark-300">Online for messages</span>
                </div>
                <button
                  type="button"
                  disabled={togglingOnline}
                  onClick={toggleOnline}
                  aria-label="Toggle online status"
                  className={`relative w-9 h-5 rounded-full transition-colors shrink-0 disabled:opacity-60 cursor-pointer ${onlineForMsg ? 'bg-green-500' : 'bg-dark-700'}`}
                >
                  {togglingOnline
                    ? <Loader2 className="absolute inset-0 m-auto w-3 h-3 text-white animate-spin" />
                    : <span className={`absolute top-0.5 w-4 h-4 rounded-full bg-white shadow transition-transform ${onlineForMsg ? 'translate-x-4' : 'translate-x-0.5'}`} />
                  }
                </button>
              </div>
            </div>

            {/* Navigation items */}
            <div className="py-1.5">
              <DropItem icon={User}        label="Your profile"     onClick={() => go(isFreelancer ? '/freelancer/profile' : '/settings')} />
              {isFreelancer && (
                <DropItem icon={TrendingUp} label="Stats and trends" onClick={() => go('/reports')} />
              )}
              <DropItem icon={ShieldCheck} label="Account health"   onClick={() => go('/account-health')} />
              <DropItem icon={BadgeCheck}  label="Membership plan"  onClick={() => go('/membership')} />
              {isFreelancer && (
                <button
                  type="button"
                  className="w-full flex items-center gap-2.5 px-3.5 py-2 text-sm text-dark-300 hover:text-dark-100 hover:bg-dark-800 transition-colors cursor-pointer"
                  onClick={() => go('/connects')}
                >
                  <Zap className="w-3.5 h-3.5 text-dark-500 shrink-0" strokeWidth={1.75} />
                  <span>Connects</span>
                  <span className="ml-auto text-xs text-dark-500 font-medium">
                    {user?.connects_balance ?? 0} left
                  </span>
                </button>
              )}
            </div>

            {/* Theme switcher */}
            <div className="px-4 py-2.5 border-t border-dark-800">
              <div className="flex items-center justify-between mb-1.5">
                <span className="text-xs text-dark-400">Theme</span>
                <span className="text-xs text-dark-500 capitalize">{theme}</span>
              </div>
              <div className="flex gap-1">
                {THEME_OPTIONS.map(({ value, icon: Icon, label }) => (
                  <button
                    key={value}
                    onClick={() => setTheme(value)}
                    title={label}
                    className={`flex-1 flex items-center justify-center gap-1 py-1.5 rounded-lg text-xs transition-colors ${
                      theme === value
                        ? 'bg-primary-500/20 text-primary-400'
                        : 'text-dark-500 hover:text-dark-200 hover:bg-dark-800'
                    }`}
                  >
                    <Icon className="w-3.5 h-3.5" strokeWidth={1.75} />
                    <span className="hidden sm:inline">{label}</span>
                  </button>
                ))}
              </div>
            </div>

            <div className="py-1.5 border-t border-dark-800">
              <DropItem icon={Settings} label="Account settings" onClick={() => go('/settings')} />
            </div>

            <div className="py-1.5 border-t border-dark-800">
              <button
                type="button"
                onClick={handleLogout}
                className="w-full flex items-center gap-2.5 px-3.5 py-2 text-sm text-dark-400 hover:text-red-400 hover:bg-red-500/10 transition-colors cursor-pointer"
              >
                <LogOut className="w-3.5 h-3.5 shrink-0" strokeWidth={1.75} />
                Log out
              </button>
            </div>
          </AnimatedDropdown>
        </div>
      </div>
    </header>
  );
}

function DropItem({ icon: Icon, label, onClick }) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="w-full flex items-center gap-2.5 px-3.5 py-2 text-sm text-dark-300 hover:text-dark-100 hover:bg-dark-800 transition-colors cursor-pointer"
    >
      <Icon className="w-3.5 h-3.5 text-dark-500 shrink-0" strokeWidth={1.75} />
      {label}
    </button>
  );
}

function AnimatedDropdown({ open, children }) {
  if (!open) return null;
  return (
    <div className="absolute right-0 top-full mt-1.5 w-64 card shadow-float z-50 animate-scale-in">
      {children}
    </div>
  );
}
