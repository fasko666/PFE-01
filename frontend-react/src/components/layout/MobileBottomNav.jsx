import { Link, useLocation } from 'react-router-dom';
import {
  Home, Search, MessageSquare, User, Briefcase,
  LayoutDashboard, DollarSign, Plus,
} from 'lucide-react';
import useAuthStore from '../../store/authStore';
import useChatStore from '../../store/chatStore';

export default function MobileBottomNav() {
  const { token, user } = useAuthStore();
  const location = useLocation();
  const unreadByConversation = useChatStore((s) => s.unreadByConversation);
  const msgUnread = Object.values(unreadByConversation).reduce((a, b) => a + (b || 0), 0);

  const role = user?.role;

  const items = token
    ? role === 'freelancer'
      ? [
          { to: '/freelancer/dashboard', icon: LayoutDashboard, label: 'Home' },
          { to: '/search?type=jobs',     icon: Search,          label: 'Find Work' },
          { to: '/messages',             icon: MessageSquare,   label: 'Messages', badge: msgUnread },
          { to: '/freelancer/profile',   icon: User,            label: 'Profile' },
        ]
      : role === 'client'
      ? [
          { to: '/client/dashboard', icon: LayoutDashboard, label: 'Home' },
          { to: '/freelancers',       icon: Search,          label: 'Talent' },
          { to: '/jobs/post',         icon: Plus,            label: 'Post Job' },
          { to: '/messages',          icon: MessageSquare,   label: 'Messages', badge: msgUnread },
          { to: '/payments',          icon: DollarSign,      label: 'Payments' },
        ]
      : [
          { to: '/admin/dashboard', icon: LayoutDashboard, label: 'Dashboard' },
          { to: '/freelancers',      icon: Search,          label: 'Users' },
          { to: '/messages',         icon: MessageSquare,   label: 'Messages', badge: msgUnread },
          { to: '/payments',         icon: DollarSign,      label: 'Payments' },
        ]
    : [
        { to: '/',                 icon: Home,          label: 'Home' },
        { to: '/freelancers',      icon: Search,        label: 'Talent' },
        { to: '/search?type=jobs', icon: Briefcase,     label: 'Jobs' },
        { to: '/pricing',          icon: DollarSign,    label: 'Pricing' },
        { to: '/login',            icon: User,          label: 'Login' },
      ];

  return (
    <nav
      className="md:hidden fixed bottom-0 left-0 right-0 z-[9998] border-t border-dark-800"
      style={{
        backgroundColor: 'rgb(var(--c-dark-950) / 0.98)',
        backdropFilter: 'blur(24px)',
        WebkitBackdropFilter: 'blur(24px)',
        paddingBottom: 'env(safe-area-inset-bottom)',
      }}
    >
      <div className="flex items-stretch h-14">
        {items.map((item) => {
          const Icon = item.icon;
          const isActive = item.to === '/'
            ? location.pathname === '/'
            : location.pathname.startsWith(item.to.split('?')[0]);

          return (
            <Link
              key={item.to}
              to={item.to}
              className="flex-1 flex flex-col items-center justify-center gap-0.5 relative"
            >
              {isActive && (
                <span className="absolute top-0 left-1/2 -translate-x-1/2 w-8 h-0.5 bg-primary-500 rounded-full" />
              )}
              <div className="relative">
                <Icon
                  className={`w-5 h-5 transition-colors ${isActive ? 'text-primary-400' : 'text-dark-500'}`}
                  strokeWidth={isActive ? 2.5 : 1.75}
                />
                {(item.badge || 0) > 0 && (
                  <span className="absolute -top-1 -right-2 min-w-[14px] h-3.5 bg-primary-500 text-white text-[8px] font-bold rounded-full flex items-center justify-center px-0.5">
                    {item.badge > 9 ? '9+' : item.badge}
                  </span>
                )}
              </div>
              <span className={`text-[9px] font-medium leading-none ${isActive ? 'text-primary-400' : 'text-dark-600'}`}>
                {item.label}
              </span>
            </Link>
          );
        })}
      </div>
    </nav>
  );
}
