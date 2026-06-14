import { useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { AlertTriangle, Info, Trash2, CheckCircle } from 'lucide-react';
import { create } from 'zustand';

/* ── Global store ─────────────────────────────────────────── */
export const useConfirmStore = create((set) => ({
  open:      false,
  title:     '',
  message:   '',
  variant:   'default', // 'default' | 'danger' | 'success'
  confirmLabel: 'Confirm',
  cancelLabel:  'Cancel',
  resolve:   null,

  show: ({ title, message, variant = 'default', confirmLabel, cancelLabel }) =>
    new Promise((resolve) =>
      set({
        open: true, title, message, variant,
        confirmLabel: confirmLabel || (variant === 'danger' ? 'Delete' : 'Confirm'),
        cancelLabel:  cancelLabel  || 'Cancel',
        resolve,
      })
    ),

  answer: (result, get) => {
    const { resolve } = get();
    set({ open: false });
    setTimeout(() => resolve?.(result), 200);
  },
}));

/* ── Exported helper — drop-in for window.confirm() ──────── */
export async function confirm(message, { title, variant, confirmLabel, cancelLabel } = {}) {
  return useConfirmStore.getState().show({
    message,
    title:        title        || (variant === 'danger' ? 'Are you sure?' : 'Confirm action'),
    variant:      variant      || 'default',
    confirmLabel,
    cancelLabel,
  });
}

/* ── Modal component (render once in App.jsx) ─────────────── */
const ICON = {
  danger:  <Trash2       className="w-6 h-6 text-red-400"     strokeWidth={1.75} />,
  success: <CheckCircle  className="w-6 h-6 text-green-400"   strokeWidth={1.75} />,
  default: <Info         className="w-6 h-6 text-primary-400" strokeWidth={1.75} />,
};

const ICON_BG = {
  danger:  'bg-red-500/10 border-red-500/20',
  success: 'bg-green-500/10 border-green-500/20',
  default: 'bg-primary-500/10 border-primary-500/20',
};

const BTN_CONFIRM = {
  danger:  'bg-red-600 hover:bg-red-500 text-white',
  success: 'bg-green-600 hover:bg-green-500 text-white',
  default: 'bg-primary-600 hover:bg-primary-500 text-white',
};

export default function ConfirmModal() {
  const { open, title, message, variant, confirmLabel, cancelLabel, answer } =
    useConfirmStore();
  const store = useConfirmStore;

  // Close on Escape
  useEffect(() => {
    if (!open) return;
    const handler = (e) => { if (e.key === 'Escape') store.getState().answer(false, store.getState()); };
    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [open]);

  return (
    <AnimatePresence>
      {open && (
        <>
          {/* Backdrop */}
          <motion.div
            key="confirm-backdrop"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.15 }}
            onClick={() => store.getState().answer(false, store.getState())}
            className="fixed inset-0 z-[99998] bg-black/60 backdrop-blur-sm"
          />

          {/* Panel */}
          <motion.div
            key="confirm-panel"
            initial={{ opacity: 0, scale: 0.93, y: 12 }}
            animate={{ opacity: 1, scale: 1,    y: 0  }}
            exit={{    opacity: 0, scale: 0.93, y: 12 }}
            transition={{ duration: 0.18, ease: [0.4, 0, 0.2, 1] }}
            className="fixed inset-0 z-[99999] flex items-center justify-center p-4 pointer-events-none"
          >
            <div
              className="pointer-events-auto w-full max-w-sm rounded-2xl border border-dark-700 bg-dark-900 shadow-2xl p-6 flex flex-col gap-5"
              onClick={(e) => e.stopPropagation()}
            >
              {/* Icon + title */}
              <div className="flex items-start gap-4">
                <div className={`shrink-0 w-11 h-11 rounded-xl border flex items-center justify-center ${ICON_BG[variant]}`}>
                  {ICON[variant]}
                </div>
                <div className="min-w-0 pt-0.5">
                  <h3 className="text-base font-semibold text-dark-50 leading-snug">{title}</h3>
                  <p className="text-sm text-dark-400 mt-1 leading-relaxed">{message}</p>
                </div>
              </div>

              {/* Actions */}
              <div className="flex items-center justify-end gap-3 pt-1">
                <button
                  onClick={() => store.getState().answer(false, store.getState())}
                  className="px-4 py-2 text-sm font-semibold rounded-xl border border-dark-700 text-dark-300 hover:bg-dark-800 hover:text-dark-100 transition-colors"
                >
                  {cancelLabel}
                </button>
                <button
                  onClick={() => store.getState().answer(true, store.getState())}
                  className={`px-5 py-2 text-sm font-semibold rounded-xl transition-colors ${BTN_CONFIRM[variant]}`}
                >
                  {confirmLabel}
                </button>
              </div>
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}
