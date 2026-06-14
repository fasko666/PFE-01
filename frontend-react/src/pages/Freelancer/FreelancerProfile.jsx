import { useState, useEffect, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import {
  MapPin, Star, DollarSign, MessageSquare,
  UserPlus, Edit3, X, Briefcase, ExternalLink, Trash2,
  BadgeCheck, Send, AlertCircle, Camera, Loader2,
  Clock, CheckCircle2, TrendingUp, Globe, Award, Plus,
  ChevronRight,
} from 'lucide-react';
import { api } from '../../api';
import useAuthStore from '../../store/authStore';
import UserAvatar from '../../components/ui/UserAvatar';
import toast from 'react-hot-toast';
import { compressImage } from '../../utils/imageCompressor';

const AVAIL_CONFIG = {
  available:     { label: 'Available',     cls: 'text-green-400 bg-green-500/10 border-green-500/20',  dot: 'bg-green-400' },
  busy:          { label: 'Busy',          cls: 'text-yellow-400 bg-yellow-500/10 border-yellow-500/20', dot: 'bg-yellow-400' },
  not_available: { label: 'Not Available', cls: 'text-red-400 bg-red-500/10 border-red-500/20',    dot: 'bg-red-400' },
};

const TABS = ['overview', 'portfolio', 'reviews'];

const fadeUp = (delay = 0) => ({
  initial: { opacity: 0, y: 14 },
  animate: { opacity: 1, y: 0 },
  transition: { duration: 0.38, delay, ease: [0.4, 0, 0.2, 1] },
});

// ── Star display ──────────────────────────────────────────────────────────────
function StarDisplay({ rating, count, size = 'sm' }) {
  const r = Math.round(parseFloat(rating) || 0);
  const sz = size === 'sm' ? 'w-3 h-3' : 'w-4 h-4';
  return (
    <div className="flex items-center gap-1.5">
      <div className="flex">
        {[1, 2, 3, 4, 5].map((n) => (
          <Star
            key={n}
            className={`${sz} ${n <= r ? 'text-yellow-400 fill-yellow-400' : 'text-dark-700'}`}
            strokeWidth={n <= r ? 0 : 1.5}
          />
        ))}
      </div>
      {count !== undefined && (
        <span className="text-xs text-dark-500">
          {parseFloat(rating || 0).toFixed(1)} ({count})
        </span>
      )}
    </div>
  );
}

function StarInput({ value, onChange }) {
  const [hovered, setHovered] = useState(0);
  const active = hovered || value;
  return (
    <div className="flex gap-1">
      {[1, 2, 3, 4, 5].map((n) => (
        <button
          key={n}
          type="button"
          onMouseEnter={() => setHovered(n)}
          onMouseLeave={() => setHovered(0)}
          onClick={() => onChange(n)}
          className="p-0.5 transition-transform hover:scale-110 active:scale-95"
        >
          <Star
            className={`w-6 h-6 transition-colors ${
              n <= active ? 'text-yellow-400 fill-yellow-400' : 'text-dark-600'
            }`}
            strokeWidth={n <= active ? 0 : 1.5}
          />
        </button>
      ))}
    </div>
  );
}

const RATING_LABELS = ['', 'Poor', 'Fair', 'Good', 'Great', 'Excellent'];

// ── Review modal ──────────────────────────────────────────────────────────────
function ReviewModal({ freelancer, onClose, onSuccess }) {
  const [rating, setRating] = useState(0);
  const [comment, setComment] = useState('');
  const [breakdown, setBreakdown] = useState({ communication: 0, quality: 0, timeliness: 0 });
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!rating) { setError('Please select a rating'); return; }
    setSubmitting(true);
    setError('');
    try {
      const payload = {
        reviewee_id: freelancer.id,
        rating,
        comment: comment.trim() || null,
        breakdown: Object.values(breakdown).some((v) => v > 0) ? breakdown : null,
      };
      const res = await api.reviews.create(payload);
      toast.success('Review submitted!');
      onSuccess(res.data.data);
    } catch (err) {
      const msg = err.response?.data?.message || err.response?.data?.errors
        ? Object.values(err.response?.data?.errors || {}).flat().join(', ')
        : 'Failed to submit review';
      setError(typeof msg === 'string' ? msg : 'Failed to submit review');
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <AnimatePresence>
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        className="fixed inset-0 bg-black/70 backdrop-blur-sm z-50 flex items-center justify-center p-4"
        onClick={(e) => e.target === e.currentTarget && onClose()}
      >
        <motion.div
          initial={{ opacity: 0, scale: 0.95, y: 16 }}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          exit={{ opacity: 0, scale: 0.95, y: 16 }}
          transition={{ duration: 0.22 }}
          className="card p-6 w-full max-w-md shadow-dialog"
        >
          <div className="flex items-center justify-between mb-5">
            <div>
              <h2 className="text-base font-semibold text-dark-100">Write a Review</h2>
              <p className="text-xs text-dark-500 mt-0.5">for {freelancer.name}</p>
            </div>
            <button onClick={onClose} className="p-1.5 rounded-lg text-dark-500 hover:text-white hover:bg-dark-800 transition-colors">
              <X className="w-4 h-4" strokeWidth={2} />
            </button>
          </div>

          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-xs font-medium text-dark-400 mb-2">Overall Rating *</label>
              <div className="flex items-center gap-3">
                <StarInput value={rating} onChange={setRating} />
                {rating > 0 && <span className="text-sm font-medium text-yellow-400">{RATING_LABELS[rating]}</span>}
              </div>
            </div>

            <div className="space-y-2">
              <label className="block text-xs font-medium text-dark-400">Breakdown (optional)</label>
              {[
                { key: 'communication', label: 'Communication' },
                { key: 'quality',       label: 'Quality' },
                { key: 'timeliness',    label: 'Timeliness' },
              ].map(({ key, label }) => (
                <div key={key} className="flex items-center justify-between gap-3">
                  <span className="text-xs text-dark-500 w-28">{label}</span>
                  <StarInput value={breakdown[key]} onChange={(v) => setBreakdown((b) => ({ ...b, [key]: v }))} />
                </div>
              ))}
            </div>

            <div>
              <label className="block text-xs font-medium text-dark-400 mb-1.5">Comment</label>
              <textarea
                value={comment}
                onChange={(e) => setComment(e.target.value)}
                rows={3}
                maxLength={1000}
                placeholder="Share your experience working with this freelancer…"
                className="input text-sm resize-none h-24"
              />
              <p className="text-xs text-dark-600 text-right mt-1">{comment.length}/1000</p>
            </div>

            {error && (
              <div className="flex items-center gap-2 text-red-400 text-sm bg-red-500/10 border border-red-500/20 rounded-xl px-3 py-2">
                <AlertCircle className="w-4 h-4 shrink-0" strokeWidth={2} />
                {error}
              </div>
            )}

            <div className="flex gap-2 pt-1">
              <button type="button" onClick={onClose} className="btn btn-ghost btn-sm flex-1">Cancel</button>
              <button type="submit" disabled={submitting || !rating} className="btn btn-primary btn-sm flex-1 gap-1.5">
                <Send className="w-3.5 h-3.5" strokeWidth={2} />
                {submitting ? 'Submitting…' : 'Submit Review'}
              </button>
            </div>
          </form>
        </motion.div>
      </motion.div>
    </AnimatePresence>
  );
}

// ── Edit form (inline) ────────────────────────────────────────────────────────
function EditForm({ form, setForm, onSave, onCancel, saving }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 8 }}
      animate={{ opacity: 1, y: 0 }}
      className="rounded-2xl border border-primary-500/20 bg-dark-900/80 p-5 space-y-4"
    >
      <h3 className="text-sm font-semibold text-dark-100">Edit Profile</h3>
      <div className="space-y-3">
        <div>
          <label className="text-2xs text-dark-500 font-semibold uppercase tracking-wider mb-1 block">Professional Title</label>
          <input
            value={form.title}
            onChange={(e) => setForm({ ...form, title: e.target.value })}
            className="input font-medium"
            placeholder="e.g. Full-Stack Developer"
          />
        </div>
        <div>
          <label className="text-2xs text-dark-500 font-semibold uppercase tracking-wider mb-1 block">Bio</label>
          <textarea
            value={form.bio}
            onChange={(e) => setForm({ ...form, bio: e.target.value })}
            className="input h-28 resize-none text-sm leading-relaxed"
            placeholder="Tell clients about yourself, your experience, and what makes you stand out…"
          />
        </div>
        <div className="grid grid-cols-2 gap-3">
          <div>
            <label className="text-2xs text-dark-500 font-semibold uppercase tracking-wider mb-1 block">Hourly Rate (USD)</label>
            <div className="relative">
              <span className="absolute left-3 top-1/2 -translate-y-1/2 text-dark-500 text-sm">$</span>
              <input
                type="number"
                value={form.hourly_rate}
                onChange={(e) => setForm({ ...form, hourly_rate: e.target.value })}
                className="input pl-7"
                placeholder="e.g. 45"
              />
            </div>
          </div>
          <div>
            <label className="text-2xs text-dark-500 font-semibold uppercase tracking-wider mb-1 block">Country</label>
            <input
              value={form.country}
              onChange={(e) => setForm({ ...form, country: e.target.value })}
              className="input"
              placeholder="e.g. Morocco"
            />
          </div>
        </div>
        <div>
          <label className="text-2xs text-dark-500 font-semibold uppercase tracking-wider mb-1 block">Availability</label>
          <select
            value={form.availability}
            onChange={(e) => setForm({ ...form, availability: e.target.value })}
            className="input"
          >
            <option value="available">Available for work</option>
            <option value="busy">Busy</option>
            <option value="not_available">Not available</option>
          </select>
        </div>
      </div>
      <div className="flex gap-2 pt-1">
        <button onClick={onCancel} className="btn btn-ghost btn-sm gap-1.5 flex-1">
          <X className="w-3.5 h-3.5" /> Cancel
        </button>
        <button onClick={onSave} disabled={saving} className="btn btn-primary btn-sm flex-1">
          {saving ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <CheckCircle2 className="w-3.5 h-3.5" />}
          {saving ? 'Saving…' : 'Save Changes'}
        </button>
      </div>
    </motion.div>
  );
}

// ── Main component ────────────────────────────────────────────────────────────
export default function FreelancerProfile() {
  const { username } = useParams();
  const navigate = useNavigate();
  const { user, updateUser } = useAuthStore();
  const isOwnProfile = !username || username === user?.username;

  const [profile, setProfile] = useState(null);
  const [loading, setLoading] = useState(true);
  const [editing, setEditing] = useState(false);
  const [saving, setSaving] = useState(false);
  const [activeTab, setActiveTab] = useState('overview');
  const [skillInput, setSkillInput] = useState(false);
  const [skillText, setSkillText] = useState('');
  const [showReviewModal, setShowReviewModal] = useState(false);
  const [uploadingAvatar, setUploadingAvatar] = useState(false);
  const avatarInputRef = useRef(null);

  const [form, setForm] = useState({
    title: '', bio: '', hourly_rate: '', country: '', phone: '',
    availability: 'available',
  });

  const loadProfile = async () => {
    try {
      const target = username || user?.username;
      const res = target ? await api.freelancers.get(target) : await api.auth.me();
      const data = res.data.data || res.data.user;
      setProfile(data);
      setForm({
        title: data.freelancer_profile?.title || '',
        bio: data.freelancer_profile?.bio || '',
        hourly_rate: data.freelancer_profile?.hourly_rate || '',
        country: data.country || '',
        phone: data.phone || '',
        availability: data.freelancer_profile?.availability || 'available',
      });
    } catch {
      toast.error('Profile not found');
      navigate('/freelancers');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { loadProfile(); }, [username]);

  const saveProfile = async () => {
    setSaving(true);
    try {
      const payload = {
        ...form,
        hourly_rate: form.hourly_rate !== '' ? form.hourly_rate : null,
      };
      const res = await api.freelancers.updateProfile(payload);
      setProfile((p) => ({ ...p, ...res.data.data }));
      if (isOwnProfile) updateUser(res.data.data);
      setEditing(false);
      toast.success('Profile updated!');
    } catch (err) {
      const msg = err?.response?.data?.message
        || Object.values(err?.response?.data?.errors || {}).flat()[0]
        || 'Failed to update profile';
      toast.error(msg);
    } finally {
      setSaving(false);
    }
  };

  const addSkill = async (e) => {
    if ((e.key === 'Enter' || e.key === ',') && skillText.trim()) {
      e.preventDefault();
      const skill = skillText.trim().replace(',', '');
      try {
        await api.freelancers.addSkills({ skills: [skill] });
        await loadProfile();
        setSkillText('');
        setSkillInput(false);
        toast.success('Skill added');
      } catch { toast.error('Failed to add skill'); }
    }
    if (e.key === 'Escape') { setSkillInput(false); setSkillText(''); }
  };

  const removePortfolio = async (id) => {
    try {
      await api.freelancers.deletePortfolio(id);
      setProfile((p) => ({ ...p, portfolios: p.portfolios?.filter((x) => x.id !== id) }));
    } catch { toast.error('Failed to remove portfolio'); }
  };

  const handleAvatarChange = async (e) => {
    const file = e.target.files?.[0];
    if (!file) return;
    if (!file.type.startsWith('image/')) { toast.error('Please choose an image file'); return; }
    setUploadingAvatar(true);
    try {
      const compressed = await compressImage(file);
      const { data } = await api.auth.updateAvatar({ avatar: compressed });
      setProfile((p) => ({ ...p, avatar_url: data.avatar_url }));
      updateUser({ avatar_url: data.avatar_url });
      toast.success('Photo updated!');
    } catch (err) {
      toast.error(err?.response?.data?.message || 'Failed to update photo');
    } finally {
      setUploadingAvatar(false);
      e.target.value = '';
    }
  };

  const handleReviewSuccess = (newReview) => {
    setShowReviewModal(false);
    const reviewerData = { id: user?.id, name: user?.name, username: user?.username, avatar_url: user?.avatar_url };
    const full = { ...newReview, reviewer: reviewerData };
    setProfile((p) => {
      const reviews = [full, ...(p.reviews || [])];
      const avg = reviews.reduce((s, r) => s + parseFloat(r.rating), 0) / reviews.length;
      return {
        ...p, reviews,
        reviews_count: reviews.length,
        avg_rating: avg.toFixed(2),
        freelancer_profile: p.freelancer_profile
          ? { ...p.freelancer_profile, avg_rating: avg.toFixed(2), total_reviews: reviews.length }
          : p.freelancer_profile,
      };
    });
  };

  const deleteReview = async (reviewId) => {
    try {
      await api.reviews.delete(reviewId);
      toast.success('Review deleted');
      setProfile((p) => {
        const reviews = (p.reviews || []).filter((r) => r.id !== reviewId);
        const avg = reviews.length ? reviews.reduce((s, r) => s + parseFloat(r.rating), 0) / reviews.length : 0;
        return {
          ...p, reviews,
          reviews_count: reviews.length,
          avg_rating: avg.toFixed(2),
          freelancer_profile: p.freelancer_profile
            ? { ...p.freelancer_profile, avg_rating: avg.toFixed(2), total_reviews: reviews.length }
            : p.freelancer_profile,
        };
      });
    } catch { toast.error('Failed to delete review'); }
  };

  const alreadyReviewed = profile?.reviews?.some((r) => r.reviewer?.id === user?.id);
  const canReview = !isOwnProfile && user && user.role !== 'freelancer' && !alreadyReviewed;

  // ── Loading skeleton ────────────────────────────────────────────────────────
  if (loading) {
    return (
      <div className={username ? 'min-h-screen bg-dark-950 px-4 py-6' : ''} style={username ? { paddingTop: 64 } : {}}>
        <div className="max-w-5xl mx-auto space-y-4 animate-pulse">
          <div className="card overflow-hidden">
            <div className="h-40 skeleton rounded-none" />
            <div className="px-6 pb-6 -mt-12 flex items-end gap-4">
              <div className="skeleton w-24 h-24 rounded-2xl shrink-0" />
              <div className="flex-1 pt-14 space-y-2">
                <div className="skeleton h-6 w-40 rounded-lg" />
                <div className="skeleton h-4 w-28 rounded-lg" />
              </div>
            </div>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div className="md:col-span-1 space-y-4">
              <div className="card p-5 h-40 skeleton" />
              <div className="card p-5 h-32 skeleton" />
            </div>
            <div className="md:col-span-2 card p-5 h-64 skeleton" />
          </div>
        </div>
      </div>
    );
  }

  if (!profile) return null;

  const avgRating = parseFloat(profile.avg_rating) || parseFloat(profile.freelancer_profile?.avg_rating) || 0;
  const avail = AVAIL_CONFIG[profile.freelancer_profile?.availability] || AVAIL_CONFIG.available;
  const memberSince = profile.created_at
    ? new Date(profile.created_at).toLocaleDateString('en-US', { month: 'short', year: 'numeric' })
    : null;

  return (
    <div className={username ? 'min-h-screen bg-dark-950' : ''} style={username ? { paddingTop: 64 } : {}}>
    <div className="max-w-5xl mx-auto px-4 py-6 space-y-5">

      {/* ── HERO CARD ─────────────────────────────────────────────────────────── */}
      <motion.div {...fadeUp(0)} className="card overflow-hidden">
        {/* Banner */}
        <div className="relative h-40 overflow-hidden bg-gradient-to-br from-primary-900 via-primary-700/70 to-violet-800/60">
          {/* Decorative circles */}
          <div className="absolute -top-10 -right-10 w-56 h-56 rounded-full bg-white/5" />
          <div className="absolute top-8 right-32 w-20 h-20 rounded-full bg-white/5" />
          <div className="absolute -bottom-6 -left-6 w-32 h-32 rounded-full bg-white/5" />
          <div className="absolute bottom-4 left-1/2 w-12 h-12 rounded-full bg-white/5" />
          {/* Grid pattern */}
          <div className="absolute inset-0 opacity-10"
            style={{
              backgroundImage: 'linear-gradient(rgba(255,255,255,.15) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,.15) 1px, transparent 1px)',
              backgroundSize: '40px 40px',
            }}
          />
          {isOwnProfile && (
            <button
              onClick={() => setEditing((v) => !v)}
              className="absolute top-4 right-4 inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-white/10 hover:bg-white/20 border border-white/20 text-white text-xs font-medium backdrop-blur-sm transition-all"
            >
              <Edit3 className="w-3.5 h-3.5" />
              Edit Profile
            </button>
          )}
        </div>

        {/* Avatar + identity row */}
        <div className="px-6 pb-6">
          <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 -mt-12 mb-5">
            {/* Avatar */}
            <div className="relative shrink-0 group w-fit">
              <input ref={avatarInputRef} type="file" accept="image/jpeg,image/png,image/webp" className="hidden" onChange={handleAvatarChange} />
              <div className="w-24 h-24 rounded-2xl ring-4 ring-dark-900 overflow-hidden shadow-xl">
                <UserAvatar user={profile} size={96} className="!rounded-2xl w-full h-full object-cover" />
              </div>
              {profile.is_online && !isOwnProfile && (
                <span className="absolute bottom-1.5 right-1.5 w-3.5 h-3.5 bg-green-500 rounded-full border-2 border-dark-900 shadow" />
              )}
              {isOwnProfile && (
                <button
                  onClick={() => avatarInputRef.current?.click()}
                  disabled={uploadingAvatar}
                  className="absolute inset-0 rounded-2xl flex items-center justify-center bg-black/55 opacity-0 group-hover:opacity-100 transition-opacity disabled:cursor-wait"
                  title="Change photo"
                >
                  {uploadingAvatar
                    ? <Loader2 className="w-6 h-6 text-white animate-spin" />
                    : <Camera className="w-6 h-6 text-white" />
                  }
                </button>
              )}
            </div>

            {/* Action buttons (non-owner) */}
            {!isOwnProfile && (
              <div className="flex gap-2 sm:mb-1">
                <button
                  onClick={async () => {
                    try { await api.chat.start({ user_id: profile.id }); navigate('/messages'); }
                    catch { toast.error('Failed to start chat'); }
                  }}
                  className="btn btn-ghost btn-sm gap-1.5"
                >
                  <MessageSquare className="w-3.5 h-3.5" strokeWidth={2} />
                  Message
                </button>
                <button className="btn btn-primary btn-sm gap-1.5">
                  <UserPlus className="w-3.5 h-3.5" strokeWidth={2} />
                  Hire Now
                </button>
              </div>
            )}
          </div>

          {/* Name / title / badges */}
          <div className="flex flex-wrap items-start gap-3 mb-4">
            <div className="flex-1 min-w-0">
              <div className="flex items-center gap-2 flex-wrap mb-1">
                <h1 className="text-2xl font-bold text-dark-100 leading-tight">{profile.name}</h1>
                {profile.is_verified && (
                  <BadgeCheck className="w-5 h-5 text-primary-400 shrink-0" strokeWidth={2} title="Verified" />
                )}
                {profile.freelancer_profile?.is_top_rated && (
                  <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-2xs font-bold bg-yellow-500/15 text-yellow-400 border border-yellow-500/25">
                    <Award className="w-3 h-3" />
                    Top Rated
                  </span>
                )}
              </div>
              <p className="text-dark-300 font-medium mb-2">
                {profile.freelancer_profile?.title || 'Freelancer'}
              </p>
              <div className="flex flex-wrap items-center gap-3 text-xs text-dark-500">
                {profile.country && (
                  <span className="flex items-center gap-1">
                    <MapPin className="w-3 h-3" strokeWidth={2} />
                    {profile.country}
                  </span>
                )}
                {memberSince && (
                  <span className="flex items-center gap-1">
                    <Clock className="w-3 h-3" strokeWidth={2} />
                    Member since {memberSince}
                  </span>
                )}
                {(profile.reviews_count || 0) > 0 && (
                  <StarDisplay rating={avgRating} count={profile.reviews_count} />
                )}
              </div>
            </div>

            {/* Rate + availability pill */}
            <div className="flex flex-col items-end gap-2 shrink-0">
              {profile.freelancer_profile?.hourly_rate && (
                <div className="text-right">
                  <div className="text-2xl font-bold text-green-400">
                    ${profile.freelancer_profile.hourly_rate}
                    <span className="text-sm font-normal text-dark-500">/hr</span>
                  </div>
                </div>
              )}
              <span className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-2xs font-semibold border ${avail.cls}`}>
                <span className={`w-1.5 h-1.5 rounded-full ${avail.dot}`} />
                {avail.label}
              </span>
            </div>
          </div>

          {/* Edit form */}
          <AnimatePresence>
            {editing && (
              <EditForm
                form={form}
                setForm={setForm}
                onSave={saveProfile}
                onCancel={() => setEditing(false)}
                saving={saving}
              />
            )}
          </AnimatePresence>
        </div>
      </motion.div>

      {/* ── TWO-COLUMN LAYOUT ──────────────────────────────────────────────────── */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-5">

        {/* LEFT SIDEBAR */}
        <div className="md:col-span-1 space-y-4">

          {/* Stats card */}
          <motion.div {...fadeUp(0.06)} className="card p-5 space-y-4">
            <h3 className="text-xs font-bold text-dark-400 uppercase tracking-wider">Stats</h3>
            <div className="space-y-3">
              {[
                { icon: Briefcase,   label: 'Jobs Completed', value: profile.completed_contracts || 0,         color: 'text-primary-400', bg: 'bg-primary-500/10' },
                { icon: Star,        label: 'Avg Rating',     value: avgRating > 0 ? avgRating.toFixed(1) : '—', color: 'text-yellow-400',  bg: 'bg-yellow-500/10' },
                { icon: TrendingUp,  label: 'Success Rate',   value: profile.success_rate ? `${profile.success_rate}%` : '—', color: 'text-green-400', bg: 'bg-green-500/10' },
                { icon: Globe,       label: 'Reviews',        value: profile.reviews_count || 0,               color: 'text-violet-400',  bg: 'bg-violet-500/10' },
              ].map(({ icon: Icon, label, value, color, bg }) => (
                <div key={label} className="flex items-center gap-3">
                  <div className={`w-8 h-8 rounded-xl ${bg} flex items-center justify-center shrink-0`}>
                    <Icon className={`w-4 h-4 ${color}`} strokeWidth={1.75} />
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-2xs text-dark-500">{label}</p>
                    <p className="text-sm font-bold text-dark-100">{value}</p>
                  </div>
                </div>
              ))}
            </div>
          </motion.div>

          {/* Skills card */}
          <motion.div {...fadeUp(0.09)} className="card p-5 space-y-3">
            <div className="flex items-center justify-between">
              <h3 className="text-xs font-bold text-dark-400 uppercase tracking-wider">Skills</h3>
              {isOwnProfile && (
                <button
                  onClick={() => setSkillInput(true)}
                  className="w-6 h-6 rounded-lg bg-dark-800 hover:bg-dark-700 flex items-center justify-center text-dark-400 hover:text-white transition-colors"
                  title="Add skill"
                >
                  <Plus className="w-3.5 h-3.5" />
                </button>
              )}
            </div>
            <div className="flex flex-wrap gap-1.5">
              {profile.skills?.map((s) => (
                <span key={s.id} className="px-2.5 py-1 rounded-full text-2xs font-semibold bg-primary-500/10 text-primary-300 border border-primary-500/20">
                  {s.name}
                </span>
              ))}
              {!profile.skills?.length && !isOwnProfile && (
                <p className="text-xs text-dark-600 italic">No skills listed</p>
              )}
            </div>
            <AnimatePresence>
              {skillInput && (
                <motion.div initial={{ opacity: 0, height: 0 }} animate={{ opacity: 1, height: 'auto' }} exit={{ opacity: 0, height: 0 }}>
                  <input
                    autoFocus
                    value={skillText}
                    onChange={(e) => setSkillText(e.target.value)}
                    onKeyDown={addSkill}
                    className="w-full px-3 py-1.5 rounded-xl border border-dashed border-primary-500/40 bg-transparent text-xs text-dark-300 focus:outline-none focus:border-primary-500 placeholder:text-dark-600"
                    placeholder="Type skill, press Enter…"
                  />
                </motion.div>
              )}
            </AnimatePresence>
          </motion.div>

          {/* Bio card (sidebar on desktop) */}
          {profile.freelancer_profile?.bio && (
            <motion.div {...fadeUp(0.12)} className="card p-5 space-y-2">
              <h3 className="text-xs font-bold text-dark-400 uppercase tracking-wider">About</h3>
              <p className="text-sm text-dark-400 leading-relaxed">{profile.freelancer_profile.bio}</p>
            </motion.div>
          )}
        </div>

        {/* RIGHT MAIN */}
        <div className="md:col-span-2 space-y-4">

          {/* Tabs */}
          <motion.div {...fadeUp(0.04)} className="flex gap-1 p-1 card rounded-xl shadow-sm">
            {TABS.map((t) => (
              <button
                key={t}
                onClick={() => setActiveTab(t)}
                className={`flex-1 px-4 py-2 rounded-lg text-xs font-semibold transition-all capitalize ${
                  activeTab === t
                    ? 'bg-primary-500 text-white shadow-sm'
                    : 'text-dark-400 hover:text-dark-100 hover:bg-dark-800/60'
                }`}
              >
                {t}
                {t === 'reviews' && (profile.reviews_count || 0) > 0 && (
                  <span className={`ml-1.5 text-2xs ${activeTab === t ? 'opacity-70' : 'text-dark-600'}`}>
                    ({profile.reviews_count})
                  </span>
                )}
              </button>
            ))}
          </motion.div>

          {/* Tab content */}
          <AnimatePresence mode="wait">

            {/* OVERVIEW */}
            {activeTab === 'overview' && (
              <motion.div key="overview" initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0 }} transition={{ duration: 0.18 }}>
                {profile.freelancer_profile?.bio ? (
                  <div className="card p-5 space-y-3 md:hidden mb-4">
                    <h3 className="text-sm font-semibold text-dark-100">About</h3>
                    <p className="text-sm text-dark-400 leading-relaxed">{profile.freelancer_profile.bio}</p>
                  </div>
                ) : null}

                {/* Experience / recent jobs placeholder */}
                <div className="card p-5 space-y-4">
                  <div className="flex items-center justify-between">
                    <h3 className="text-sm font-semibold text-dark-100">Work Experience</h3>
                  </div>
                  {(profile.completed_contracts || 0) > 0 ? (
                    <div className="space-y-3">
                      <div className="flex items-center gap-3 p-3 rounded-xl bg-dark-800/50 border border-dark-700/50">
                        <div className="w-10 h-10 rounded-xl bg-primary-500/10 flex items-center justify-center shrink-0">
                          <Briefcase className="w-5 h-5 text-primary-400" strokeWidth={1.75} />
                        </div>
                        <div>
                          <p className="text-sm font-semibold text-dark-100">
                            {profile.completed_contracts} completed contract{profile.completed_contracts !== 1 ? 's' : ''}
                          </p>
                          <p className="text-xs text-dark-500">on Panda platform</p>
                        </div>
                        <CheckCircle2 className="w-4 h-4 text-green-400 ml-auto shrink-0" />
                      </div>
                    </div>
                  ) : (
                    <div className="py-10 text-center">
                      <Briefcase className="w-9 h-9 text-dark-700 mx-auto mb-3" strokeWidth={1.5} />
                      <p className="text-sm text-dark-500">No completed contracts yet</p>
                    </div>
                  )}
                </div>
              </motion.div>
            )}

            {/* PORTFOLIO */}
            {activeTab === 'portfolio' && (
              <motion.div key="portfolio" initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0 }} transition={{ duration: 0.18 }} className="card p-5">
                <h3 className="text-sm font-semibold text-dark-100 mb-4">Portfolio</h3>
                {profile.portfolios?.length > 0 ? (
                  <div className="grid sm:grid-cols-2 gap-4">
                    {profile.portfolios.map((p) => (
                      <motion.div
                        key={p.id}
                        whileHover={{ y: -2 }}
                        className="group rounded-2xl overflow-hidden border border-dark-700/60 bg-dark-800/50 hover:border-primary-500/30 transition-all"
                      >
                        {p.image_url ? (
                          <div className="relative overflow-hidden h-36">
                            <img src={p.image_url} alt={p.title} className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300" />
                            <div className="absolute inset-0 bg-gradient-to-t from-dark-900/80 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
                          </div>
                        ) : (
                          <div className="h-36 bg-gradient-to-br from-dark-800 to-dark-700 flex items-center justify-center">
                            <Briefcase className="w-10 h-10 text-dark-600" strokeWidth={1.5} />
                          </div>
                        )}
                        <div className="p-3.5">
                          <h4 className="font-semibold text-dark-100 text-sm mb-1">{p.title}</h4>
                          {p.description && (
                            <p className="text-xs text-dark-400 line-clamp-2 leading-relaxed mb-2">{p.description}</p>
                          )}
                          <div className="flex items-center justify-between">
                            {p.url ? (
                              <a
                                href={p.url}
                                target="_blank"
                                rel="noreferrer"
                                className="inline-flex items-center gap-1 text-xs text-primary-400 hover:text-primary-300 transition-colors"
                                onClick={(e) => e.stopPropagation()}
                              >
                                <ExternalLink className="w-3 h-3" strokeWidth={2} />
                                View project
                              </a>
                            ) : <span />}
                            {isOwnProfile && (
                              <button
                                onClick={() => removePortfolio(p.id)}
                                className="p-1 rounded-lg text-dark-600 hover:text-red-400 hover:bg-red-500/10 transition-all"
                                title="Remove"
                              >
                                <Trash2 className="w-3.5 h-3.5" strokeWidth={2} />
                              </button>
                            )}
                          </div>
                        </div>
                      </motion.div>
                    ))}
                  </div>
                ) : (
                  <div className="py-16 text-center">
                    <div className="w-14 h-14 rounded-2xl bg-dark-800 flex items-center justify-center mx-auto mb-4">
                      <Briefcase className="w-6 h-6 text-dark-600" strokeWidth={1.5} />
                    </div>
                    <p className="text-sm font-medium text-dark-400 mb-1">No portfolio items yet</p>
                    <p className="text-xs text-dark-600">Portfolio projects will appear here</p>
                  </div>
                )}
              </motion.div>
            )}

            {/* REVIEWS */}
            {activeTab === 'reviews' && (
              <motion.div key="reviews" initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0 }} transition={{ duration: 0.18 }} className="card p-5">
                {/* Header */}
                <div className="flex items-center justify-between mb-5">
                  <div>
                    <h3 className="text-sm font-semibold text-dark-100">
                      Client Reviews
                      <span className="text-dark-500 font-normal ml-1">({profile.reviews_count || 0})</span>
                    </h3>
                    {avgRating > 0 && (
                      <div className="flex items-center gap-2 mt-1.5">
                        <span className="text-2xl font-bold text-dark-100">{avgRating.toFixed(1)}</span>
                        <div>
                          <StarDisplay rating={avgRating} size="md" />
                          <p className="text-2xs text-dark-600 mt-0.5">Based on {profile.reviews_count} review{profile.reviews_count !== 1 ? 's' : ''}</p>
                        </div>
                      </div>
                    )}
                  </div>
                  {canReview && (
                    <button onClick={() => setShowReviewModal(true)} className="btn btn-primary btn-sm gap-1.5">
                      <Star className="w-3.5 h-3.5" strokeWidth={2} />
                      Write Review
                    </button>
                  )}
                  {!isOwnProfile && alreadyReviewed && (
                    <span className="text-xs text-dark-500 flex items-center gap-1">
                      <CheckCircle2 className="w-3.5 h-3.5 text-green-400" />
                      You reviewed this freelancer
                    </span>
                  )}
                </div>

                {/* Review list */}
                {profile.reviews?.length > 0 ? (
                  <div className="space-y-4">
                    {profile.reviews.map((r) => (
                      <motion.div
                        key={r.id}
                        initial={{ opacity: 0, y: 6 }}
                        animate={{ opacity: 1, y: 0 }}
                        className="p-4 rounded-2xl border border-dark-800 bg-dark-900/50 hover:border-dark-700 transition-colors"
                      >
                        <div className="flex items-start gap-3 mb-2">
                          <img
                            src={r.reviewer?.avatar_url || `https://ui-avatars.com/api/?name=${encodeURIComponent(r.reviewer?.name || 'U')}&background=6366f1&color=fff`}
                            alt={r.reviewer?.name}
                            className="w-9 h-9 rounded-xl object-cover shrink-0 border border-dark-700"
                          />
                          <div className="flex-1 min-w-0">
                            <div className="flex items-center justify-between gap-2 flex-wrap">
                              <span className="text-sm font-semibold text-dark-100">{r.reviewer?.name}</span>
                              <div className="flex items-center gap-2">
                                <StarDisplay rating={r.rating} />
                                {user?.id === r.reviewer?.id && (
                                  <button
                                    onClick={() => deleteReview(r.id)}
                                    className="p-1 rounded-lg text-dark-600 hover:text-red-400 hover:bg-red-500/10 transition-all"
                                    title="Delete review"
                                  >
                                    <Trash2 className="w-3 h-3" strokeWidth={2} />
                                  </button>
                                )}
                              </div>
                            </div>
                            <p className="text-2xs text-dark-600 mt-0.5">
                              {new Date(r.created_at).toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' })}
                            </p>
                          </div>
                        </div>
                        {r.comment && (
                          <p className="text-sm text-dark-300 leading-relaxed pl-12">{r.comment}</p>
                        )}
                        {r.breakdown && Object.values(r.breakdown).some((v) => v > 0) && (
                          <div className="mt-3 pl-12 flex flex-wrap gap-3">
                            {[
                              { key: 'communication', label: 'Communication' },
                              { key: 'quality',       label: 'Quality' },
                              { key: 'timeliness',    label: 'Timeliness' },
                            ].filter(({ key }) => r.breakdown[key] > 0).map(({ key, label }) => (
                              <div key={key} className="flex items-center gap-1.5 text-xs text-dark-500">
                                <span>{label}</span>
                                <StarDisplay rating={r.breakdown[key]} size="sm" />
                              </div>
                            ))}
                          </div>
                        )}
                      </motion.div>
                    ))}
                  </div>
                ) : (
                  <div className="py-16 text-center">
                    <div className="w-14 h-14 rounded-2xl bg-dark-800 flex items-center justify-center mx-auto mb-4">
                      <Star className="w-6 h-6 text-dark-600" strokeWidth={1.5} />
                    </div>
                    <p className="text-sm font-medium text-dark-400 mb-1">No reviews yet</p>
                    {canReview && (
                      <button onClick={() => setShowReviewModal(true)} className="mt-3 text-sm text-primary-400 hover:text-primary-300 transition-colors">
                        Be the first to review
                      </button>
                    )}
                  </div>
                )}
              </motion.div>
            )}
          </AnimatePresence>
        </div>
      </div>

      {/* Review modal */}
      {showReviewModal && (
        <ReviewModal
          freelancer={profile}
          onClose={() => setShowReviewModal(false)}
          onSuccess={handleReviewSuccess}
        />
      )}
    </div>
    </div>
  );
}
