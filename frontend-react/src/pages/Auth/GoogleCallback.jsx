import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import { Briefcase, Building2, ArrowRight, Check } from 'lucide-react';
import useAuthStore from '../../store/authStore';
import useNotificationStore from '../../store/notificationStore';
import { auth as authApi } from '../../api';
import toast from 'react-hot-toast';

/* ── Role picker card ─────────────────────────────────── */
function RoleCard({ role, selected, onSelect }) {
  const isFreelancer = role === 'freelancer';
  return (
    <button
      type="button"
      onClick={() => onSelect(role)}
      className={`relative w-full text-left rounded-2xl border-2 p-6 transition-all duration-200 cursor-pointer group ${
        selected
          ? 'border-primary-500 bg-primary-500/8 shadow-[0_0_0_4px_rgba(67,97,255,0.12)]'
          : 'border-dark-700 bg-dark-800/50 hover:border-dark-600 hover:bg-dark-800'
      }`}
    >
      {/* Selected check */}
      {selected && (
        <span className="absolute top-4 right-4 w-6 h-6 rounded-full bg-primary-500 flex items-center justify-center">
          <Check className="w-3.5 h-3.5 text-white" strokeWidth={3} />
        </span>
      )}

      {/* Icon */}
      <div className={`w-12 h-12 rounded-xl flex items-center justify-center mb-4 transition-colors ${
        selected ? 'bg-primary-500/20' : 'bg-dark-700 group-hover:bg-dark-600'
      }`}>
        {isFreelancer
          ? <Briefcase className={`w-6 h-6 ${selected ? 'text-primary-400' : 'text-dark-300'}`} strokeWidth={1.75} />
          : <Building2  className={`w-6 h-6 ${selected ? 'text-primary-400' : 'text-dark-300'}`} strokeWidth={1.75} />
        }
      </div>

      <div className={`text-base font-bold mb-1 ${selected ? 'text-dark-50' : 'text-dark-100'}`}>
        {isFreelancer ? "I'm a Freelancer" : "I'm a Client"}
      </div>
      <div className="text-sm text-dark-400 leading-relaxed">
        {isFreelancer
          ? 'Find projects, showcase your skills, and earn on your terms.'
          : 'Post jobs, hire top talent, and get your projects done.'}
      </div>
    </button>
  );
}

/* ── Main component ───────────────────────────────────── */
export default function GoogleCallback() {
  const navigate           = useNavigate();
  const { loginWithToken, updateUser } = useAuthStore();
  const { fetch: fetchNotifs }         = useNotificationStore();

  const [status,      setStatus]      = useState('loading'); // loading | role_pick | error
  const [pendingData, setPendingData] = useState(null);      // { token, user }
  const [selected,    setSelected]    = useState(null);      // 'freelancer' | 'client'
  const [submitting,  setSubmitting]  = useState(false);

  useEffect(() => {
    const params  = new URLSearchParams(window.location.search);
    const token   = params.get('token');
    const error   = params.get('error');
    const isNew   = params.get('new_user') === '1';

    if (error || !token) {
      setStatus('error');
      setTimeout(() => navigate('/login?error=google_auth_failed', { replace: true }), 2500);
      return;
    }

    (async () => {
      try {
        loginWithToken(token, null);
        const { data } = await authApi.me();
        const user = data.user;
        loginWithToken(token, user);

        if (isNew) {
          // Check if role was pre-selected before Google redirect
          const preSelectedRole = sessionStorage.getItem('pendingGoogleRole');
          sessionStorage.removeItem('pendingGoogleRole');

          if (preSelectedRole) {
            // Auto-apply role without showing picker
            const { data: roleData } = await authApi.googleSetRole(preSelectedRole);
            updateUser(roleData.user);
            await fetchNotifs();
            toast.success(`Welcome to PANDA, ${user.name?.split(' ')[0]}!`);
            redirectToDashboard(roleData.user);
          } else {
            // Fallback: show role picker (came from somewhere without pre-selection)
            setPendingData({ token, user });
            setStatus('role_pick');
          }
        } else {
          // Existing user — proceed straight to dashboard
          await fetchNotifs();
          toast.success(`Welcome back, ${user.name?.split(' ')[0]}!`);
          redirectToDashboard(user);
        }
      } catch {
        setStatus('error');
        setTimeout(() => navigate('/login?error=google_auth_failed', { replace: true }), 2500);
      }
    })();
  }, []);

  function redirectToDashboard(user) {
    if (user.role === 'admin')        navigate('/admin/dashboard',     { replace: true });
    else if (user.role === 'client')  navigate('/client/dashboard',    { replace: true });
    else if (!user.onboarding_completed) navigate('/onboarding',       { replace: true });
    else                              navigate('/freelancer/dashboard', { replace: true });
  }

  const handleConfirm = async () => {
    if (!selected || submitting) return;
    setSubmitting(true);
    try {
      const { data } = await authApi.googleSetRole(selected);
      updateUser(data.user);
      await fetchNotifs();
      toast.success(`Welcome to PANDA, ${pendingData.user.name?.split(' ')[0]}!`);
      redirectToDashboard(data.user);
    } catch {
      toast.error('Something went wrong. Please try again.');
      setSubmitting(false);
    }
  };

  /* ── Loading screen ──────────────────────────────────── */
  if (status === 'loading') {
    return (
      <div className="min-h-screen bg-dark-950 flex items-center justify-center">
        <motion.div
          initial={{ opacity: 0, y: 12 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-center space-y-4"
        >
          <div className="w-14 h-14 rounded-2xl bg-dark-800 border border-dark-700 flex items-center justify-center mx-auto">
            <div className="w-7 h-7 border-2 border-primary-500 border-t-transparent rounded-full animate-spin" />
          </div>
          <p className="text-dark-200 font-semibold text-sm">Signing you in with Google…</p>
          <p className="text-dark-400 text-xs">Just a moment</p>
        </motion.div>
      </div>
    );
  }

  /* ── Error screen ────────────────────────────────────── */
  if (status === 'error') {
    return (
      <div className="min-h-screen bg-dark-950 flex items-center justify-center">
        <motion.div
          initial={{ opacity: 0, y: 12 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-center space-y-4"
        >
          <div className="w-14 h-14 rounded-2xl bg-red-500/10 border border-red-500/30 flex items-center justify-center mx-auto">
            <svg className="w-7 h-7 text-red-400" fill="none" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" stroke="currentColor" />
            </svg>
          </div>
          <p className="text-dark-200 font-semibold text-sm">Google sign-in failed</p>
          <p className="text-dark-400 text-xs">Redirecting back to login…</p>
        </motion.div>
      </div>
    );
  }

  /* ── Role picker screen ──────────────────────────────── */
  const user = pendingData?.user;
  return (
    <div className="min-h-screen bg-dark-950 flex items-center justify-center p-4">
      <AnimatePresence>
        <motion.div
          initial={{ opacity: 0, y: 20, scale: 0.97 }}
          animate={{ opacity: 1, y: 0,  scale: 1 }}
          transition={{ duration: 0.25, ease: [0.4, 0, 0.2, 1] }}
          className="w-full max-w-md"
        >
          {/* Header */}
          <div className="text-center mb-8">
            {user?.avatar_url && (
              <img
                src={user.avatar_url}
                alt={user.name}
                className="w-16 h-16 rounded-full mx-auto mb-4 ring-2 ring-dark-700 object-cover"
              />
            )}
            <h1 className="text-2xl font-bold text-dark-50 mb-1">
              How will you use PANDA?
            </h1>
            <p className="text-sm text-dark-400">
              Welcome, <span className="text-dark-200 font-medium">{user?.name}</span>. Choose your account type to get started.
            </p>
          </div>

          {/* Role cards */}
          <div className="flex flex-col gap-3 mb-6">
            <RoleCard role="freelancer" selected={selected === 'freelancer'} onSelect={setSelected} />
            <RoleCard role="client"     selected={selected === 'client'}     onSelect={setSelected} />
          </div>

          {/* Continue button */}
          <button
            type="button"
            onClick={handleConfirm}
            disabled={!selected || submitting}
            className="w-full flex items-center justify-center gap-2 py-3.5 rounded-xl font-semibold text-sm transition-all
              bg-primary-500 text-white hover:bg-primary-600 active:scale-[0.98]
              disabled:opacity-40 disabled:cursor-not-allowed disabled:active:scale-100"
          >
            {submitting ? (
              <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
            ) : (
              <>
                Continue
                <ArrowRight className="w-4 h-4" strokeWidth={2.5} />
              </>
            )}
          </button>

          <p className="text-center text-xs text-dark-600 mt-4">
            You can change this later in your account settings.
          </p>
        </motion.div>
      </AnimatePresence>
    </div>
  );
}
