/**
 * Real panda logo (PNG from /public/panda-logo.png).
 * - `invert={false}` → original black logo (use on light backgrounds)
 * - `invert={true}`  → inverted to white logo (use on dark backgrounds)
 */
export default function PandaLogo({ className = 'w-8 h-8', invert = false }) {
  return (
    <img
      src="/panda-logo.png"
      alt="PANDA"
      draggable={false}
      className={`${className} object-contain select-none ${invert ? 'invert' : ''}`}
    />
  );
}

/** Compact square icon tile — logo on a black tile. */
export function PandaTile({ size = 'md' }) {
  const sizes = { sm: 'w-7 h-7', md: 'w-8 h-8', lg: 'w-10 h-10', xl: 'w-14 h-14' };
  return (
    <div className={`${sizes[size]} bg-black rounded-xl flex items-center justify-center shrink-0 ring-1 ring-white/10`}>
      <PandaLogo className="w-[85%] h-[85%]" invert />
    </div>
  );
}
