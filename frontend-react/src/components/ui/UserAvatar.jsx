import { useState, useRef } from 'react';
import { Link } from 'react-router-dom';
import { LayoutDashboard, ExternalLink, MessageSquare } from 'lucide-react';

/**
 * Avatar with optional hover card.
 *
 * Props:
 *   user       — object with name, avatar_url, role, username, freelancer_profile.title
 *   name / src — overrides for when user object isn't available
 *   size       — px (default 40)
 *   ring       — show ring (default true)
 *   card       — show hover profile card (default false)
 *   onMessage  — if provided, adds a Message button to the card
 */
export default function UserAvatar({
  user,
  name,
  src,
  size = 40,
  className = '',
  ring = true,
  alt,
  card = false,
  onMessage,
}) {
  const userName   = name ?? user?.name ?? 'U';
  const initialSrc = src ?? user?.avatar_url ?? null;
  const fallback   = `https://ui-avatars.com/api/?name=${encodeURIComponent(userName)}&background=4361ff&color=fff&bold=true&size=${size * 2}`;

  const [current, setCurrent] = useState(initialSrc || fallback);
  const [errored, setErrored] = useState(false);
  const [visible, setVisible] = useState(false);
  const hideTimer = useRef(null);

  const handleError = () => {
    if (errored) return;
    setErrored(true);
    setCurrent(fallback);
  };

  const show = () => { clearTimeout(hideTimer.current); setVisible(true);  };
  const hide = () => { hideTimer.current = setTimeout(() => setVisible(false), 120); };

  const img = (
    <img
      src={current}
      alt={alt || userName}
      width={size}
      height={size}
      onError={handleError}
      referrerPolicy="no-referrer"
      className={`rounded-full object-cover ${ring ? 'ring-1 ring-dark-700' : ''} ${className}`}
      style={{ width: size, height: size }}
    />
  );

  if (!card || !user) return img;

  // Build the "View Profile / Dashboard" link
  const isFreelancer = user.role === 'freelancer';
  const profileHref  = isFreelancer && user.username
    ? `/freelancers/${user.username}`
    : user.role === 'client'
    ? `/dashboard`
    : `/dashboard`;

  const profileLabel = isFreelancer ? 'View Profile' : 'Dashboard';
  const title        = user.freelancer_profile?.title || user.title || (isFreelancer ? 'Freelancer' : 'Client');

  return (
    <div
      className="relative inline-flex"
      onMouseEnter={show}
      onMouseLeave={hide}
    >
      {img}

      {/* Hover card */}
      {visible && (
        <div
          className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 z-50 w-52 rounded-2xl border border-dark-700 bg-dark-900 shadow-2xl p-3.5 flex flex-col gap-2.5 pointer-events-auto"
          onMouseEnter={show}
          onMouseLeave={hide}
        >
          {/* Arrow */}
          <div className="absolute left-1/2 -translate-x-1/2 top-full w-0 h-0 border-l-[6px] border-r-[6px] border-t-[6px] border-l-transparent border-r-transparent border-t-dark-700" />

          {/* Profile row */}
          <div className="flex items-center gap-2.5">
            <img
              src={current}
              alt={userName}
              width={40}
              height={40}
              referrerPolicy="no-referrer"
              onError={() => setCurrent(fallback)}
              className="w-10 h-10 rounded-xl object-cover ring-1 ring-dark-700 shrink-0"
            />
            <div className="min-w-0">
              <p className="text-xs font-bold text-white truncate">{userName}</p>
              <p className="text-2xs text-dark-500 truncate">{title}</p>
            </div>
          </div>

          {/* Role badge */}
          <span className={`self-start text-2xs font-semibold px-2 py-0.5 rounded-full border ${
            isFreelancer
              ? 'text-primary-300 bg-primary-500/10 border-primary-500/30'
              : 'text-green-300 bg-green-500/10 border-green-500/30'
          }`}>
            {isFreelancer ? 'Freelancer' : 'Client'}
          </span>

          {/* Buttons */}
          <div className="flex flex-col gap-1.5">
            <Link
              to={profileHref}
              className="flex items-center justify-center gap-1.5 w-full py-1.5 rounded-lg bg-primary-500 hover:bg-primary-600 text-white text-2xs font-semibold transition-colors"
            >
              <LayoutDashboard className="w-3 h-3" strokeWidth={2} />
              {profileLabel}
            </Link>

            {onMessage && (
              <button
                onClick={onMessage}
                className="flex items-center justify-center gap-1.5 w-full py-1.5 rounded-lg border border-dark-700 hover:bg-dark-800 text-dark-300 hover:text-white text-2xs font-semibold transition-colors"
              >
                <MessageSquare className="w-3 h-3" strokeWidth={2} />
                Message
              </button>
            )}
          </div>

          {isFreelancer && user.username && (
            <Link
              to={profileHref}
              className="flex items-center gap-1 text-2xs text-dark-600 hover:text-primary-400 transition-colors"
            >
              <ExternalLink className="w-2.5 h-2.5" />
              panda.io/{user.username}
            </Link>
          )}
        </div>
      )}
    </div>
  );
}
