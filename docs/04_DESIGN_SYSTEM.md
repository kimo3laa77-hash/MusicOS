# MusicOS - Official Design System & UI Guidelines

## 1. Design Philosophy
MusicOS is designed to feel like a premium, native operating-system level application rather than a simple utility. Our philosophy is rooted in **"Cinematic Immersion."** The UI must recede, allowing the music and its corresponding artwork to take center stage. Every pixel must justify its existence. The design should evoke the emotional resonance of listening to high-fidelity audio: it must be fluid, deep, and flawless.

## 2. Visual Identity
The visual identity of MusicOS is characterized by profound depth, vivid dynamic contrasts, and buttery smoothness. It borrows the strict structural integrity of Apple's Human Interface Guidelines, the stark contrast of Spotify, and the fluid, physics-based motion of Linear. It is modern, uncluttered, and unapologetically dark.

## 3. Color System
The color system eschews hardcoded primary colors in favor of environmental adaptation.

- **AMOLED Black:** The absolute foundation. `Background: #000000`. This ensures infinite contrast on OLED screens and saves battery. 
- **Dynamic Album Colors:** The true "Primary" color is extracted at runtime from the currently playing (or focused) album artwork. The extraction algorithm must isolate:
  - *Dominant Color:* Used for large ambient gradients.
  - *Vibrant Accent:* Used for primary buttons (e.g., Play, FAB), active states, and sliders.
  - *Muted Accent:* Used for secondary text or inactive unselected states in the player.
- **Surface Colors:** Built on pure black, elevated surfaces use a translucent white overlay to create depth.
  - `Surface 0`: `#000000` (Base)
  - `Surface 1`: `rgba(255, 255, 255, 0.05)` (Cards, List Items)
  - `Surface 2`: `rgba(255, 255, 255, 0.08)` (Modals, Bottom Sheets)
  - `Surface 3`: `rgba(255, 255, 255, 0.12)` (Floating Action Buttons, Tooltips)
- **Semantic Colors:** Used strictly for system communication.
  - *Error:* `#FF453A` (Vibrant Red)
  - *Success:* `#32D74B` (Vibrant Green)
  - *Warning:* `#FF9F0A` (Vibrant Orange)
- **Elevation Colors:** Instead of shadows (which don't work on black), depth is created via Surface overlays and Glassmorphism.

## 4. Typography
MusicOS uses a modern, geometric sans-serif (e.g., Inter, Roboto, or SF Pro).
- **Display (Hero):** 32pt/40pt, Bold (700), Tracking: -2%. Used for Album Titles in Now Playing.
- **Header 1:** 24pt, Bold (700), Tracking: -1%. Used for Screen Titles (e.g., "Library").
- **Header 2:** 20pt, Semi-Bold (600). Used for Section Titles.
- **Body Large:** 16pt, Medium (500), Line Height: 150%. Used for Track Titles.
- **Body Regular:** 14pt, Regular (400), Line Height: 150%, Color: `rgba(255, 255, 255, 0.6)`. Used for Artist Names beneath tracks.
- **Caption:** 12pt, Medium (500), Tracking: 2%. Used for timestamps, metadata, and overlines.

## 5. Spacing System
A strict **8pt Grid System** dictates all margins and padding. Micro-adjustments use a 4pt sub-grid.
- `Spacing.xxs`: 4pt
- `Spacing.xs`: 8pt
- `Spacing.sm`: 12pt
- `Spacing.md`: 16pt (Standard Screen Margin)
- `Spacing.lg`: 24pt
- `Spacing.xl`: 32pt (Section gaps)
- `Spacing.xxl`: 48pt

## 6. Radius System
Corner radii communicate the component's role.
- `Radius.none`: 0px (Full screen images)
- `Radius.sm`: 8px (Small chips, context menu items)
- `Radius.md`: 12px (Standard track artwork, inner cards)
- `Radius.lg`: 24px (Modals, bottom sheets, large album covers)
- `Radius.pill`: 999px (Search bars, primary action buttons, FABs)

## 7. Elevation System
Because the background is `#000000`, traditional drop shadows are invisible. Elevation in MusicOS is achieved through three methods:
1. **Lightening the surface:** (See Surface Colors).
2. **Glassmorphism:** Blurring the background behind the elevated surface.
3. **Colored Ambient Shadows:** If an element sits above album art, a highly blurred, saturated version of the art acts as a glowing shadow.

## 8. Glassmorphism Rules
Glassmorphism is the signature aesthetic of MusicOS. It must be used deliberately, never gratuitously.
- **Formula:** `Background: rgba(25, 25, 25, 0.65)` + `Backdrop Filter: Blur(24px)` + `Saturation: 120%`.
- **Borders:** Every glass surface MUST have a `1px` inner border of `rgba(255, 255, 255, 0.1)` to define its edge against dark backgrounds.
- **Usage:** Mini Player, Bottom Navigation Bar, Context Menus, and the persistent App Bar when scrolled.

## 9. Blur System
- `Blur.sm`: 8px (Subtle depth, hovering tooltips).
- `Blur.md`: 24px (Standard Glassmorphism, Bottom Nav).
- `Blur.lg`: 64px (Heavy cinematic blurs, Now Playing background).

## 10. Shadow Rules
- **Ambient Glow:** Instead of black drop shadows, use the extracted dynamic color. (e.g., Album Cover has a shadow of `Color: Extracted Dominant`, `Blur: 48px`, `Opacity: 40%`, `Offset: 0, 16px`).
- **Text Shadow:** White text over dynamic backgrounds MUST have a subtle `0px 2px 8px rgba(0,0,0,0.4)` shadow to maintain WCAG contrast.

## 11. Motion System
Motion must feel physical, utilizing spring physics rather than linear or standard bezier curves.
- **Durations:**
  - `Fast`: 150ms (Micro-interactions, hovers, taps).
  - `Normal`: 300ms (Screen transitions, sheet expansions).
  - `Slow`: 500ms (Hero animations, full-screen player expansion).
- **Spring Curves (Physics):**
  - *Snappy:* `Stiffness: 400, Damping: 30` (Button presses).
  - *Bouncy:* `Stiffness: 300, Damping: 20` (Bottom sheet popping up).
  - *Smooth:* `Stiffness: 250, Damping: 25` (Hero transitions like Mini Player to Full Player).
- **Hero Animations:** Shared Element Transitions must connect the album art in a list to the album art in the Detail View, morphing size and corner radius seamlessly.

## 12. Iconography
- **Style:** Material 3 / SF Symbols inspired. Minimal, rounded geometry.
- **Stroke Width:** 2px consistent.
- **Active vs Inactive:** 
  - *Inactive:* Outlined (`rgba(255,255,255, 0.6)`).
  - *Active:* Filled Solid (`rgba(255,255,255, 1.0)` or Dynamic Accent Color).
- **Size:** 24x24px optical bounding box for standard icons.

## 13. Illustration Style
MusicOS avoids vector character illustrations. The "illustrations" are ambient, generated, generative art based on audio frequencies or highly blurred, slow-moving mesh gradients used for empty states.

## 14. Component Principles
- **Self-Contained:** Components must handle their own internal states (e.g., a Play button morphs to Pause internally, the parent just listens for the tap event).
- **Hitboxes:** Visual size ≠ Hitbox size. A 24px icon MUST have a minimum 48x48px invisible touch target centered around it.

## 15. Layout Rules
- **Safe Areas:** The UI must respect system window insets (Notch, status bar, gesture navigation bar). 
- **Margins:** 16pt standard side margins on mobile.
- **Grids:** Playlists and albums use adaptive CSS-style grids (e.g., 2 columns on phones, 4 on tablets) with 16pt gaps.

## 16. Responsive Rules
- UI components scale fluidly, not abruptly.
- **Breakpoints:**
  - `< 600dp:` Mobile (Bottom Nav, 2-column grids).
  - `600dp - 840dp:` Tablet Portrait (Bottom Nav or Side Rail, 3-column grids, modal players become centered floating cards).
  - `> 840dp:` Tablet Landscape/Foldable Open (Persistent Side Navigation Rail, 4+ column grids, split-pane layouts).

## 17. Accessibility Rules
- **Contrast:** All primary text must pass WCAG AA (4.5:1). If dynamic color extraction picks a color that is too light, the algorithm must artificially darken it to ensure white text remains readable.
- **Touch Targets:** Absolute minimum 48x48dp.
- **Screen Readers:** Every icon button MUST have a semantic label (e.g., `aria-label="Play Track"`).

## 18. Design Tokens
The engineering team must map these exactly to variables:
- `color-surface-base`
- `color-text-primary`
- `color-text-secondary`
- `color-accent-dynamic`
- `spacing-md`
- `radius-pill`
- `motion-spring-snappy`

## 19. Component States
Every interactive component (Buttons, List Tiles, Cards) must define:
- **Default:** Opacity 100%, standard elevation.
- **Hover:** (For mouse/pointer) Surface overlay lightens by `4%`.
- **Pressed (Active):** Element physically scales down to `0.95` instantly, opacity drops to `80%`. On release, springs back to `1.0`.
- **Focused:** (For D-Pad/Keyboard) A 2px solid white outline, offset by 4px from the component.
- **Disabled:** Opacity drops to `30%`. Pointer events ignored.
- **Loading:** Element is replaced by, or overlaid with, a shimmering skeleton.
- **Selected:** Background changes to a highly transparent version of the Dynamic Accent color (`rgba(Accent, 0.15)`), text turns to pure Accent color.

## 20. Haptic Feedback Guidelines
Haptics elevate the premium feel. They must correspond to physical actions.
- **Light Tick:** Scrolling past an A-Z index letter, reordering a queue item.
- **Medium Click:** Tapping Play/Pause, skipping tracks, toggling a switch.
- **Heavy Impact:** Destructive actions, clearing a queue, error dialog appearing.
- **Continuous (Rumble):** Holding and dragging the seek bar scrubber.

## 21. Micro Interactions
- **Play/Pause Morph:** The Play triangle smoothly morphs into two Pause bars over 250ms.
- **Favorite Heart:** Tapping the heart icon triggers a quick 150ms scale-up (1.3x) with a burst of particles, settling into the Filled state.
- **List Ripple:** Tapping a track tile creates a subtle, slow-moving ripple effect constrained to the tile bounds, utilizing the dynamic accent color at `10%` opacity.

## 22. Empty States
Empty states must never be dead ends. They must be friendly and actionable.
- **Visual:** A soft, slow-moving mesh gradient background.
- **Copy:** "Your queue is empty." -> "Let's find some music."
- **Action:** A primary pill button leading to the Library or Search.

## 23. Loading Skeletons
Instead of generic spinning circles, MusicOS uses shimmering skeletons.
- **Color:** `Surface 1` (`rgba(255,255,255, 0.05)`).
- **Shimmer:** A linear gradient passing over the skeleton from left to right over `1200ms`.
- **Shape:** Skeletons must exactly match the geometry of the content they are loading (e.g., a circle for an artist profile, a 16pt high rounded rectangle for text).

## 24. Error UI
Errors must not punish the user.
- **Inline Errors:** Preferred over dialogs. If an image fails to load, display a beautiful fallback icon on a subtle gradient surface, not a broken image link.
- **Snackbars:** Used for transient errors ("Failed to add to queue"). Pill-shaped, floating at the bottom, auto-dismissing after 3 seconds.

## 25. Premium UI Principles
What makes MusicOS feel like a $10/month subscription app?
- **Zero Jitter:** Images fade in smoothly (200ms) once loaded; they never "pop" into existence.
- **Edge-to-Edge:** Artwork bleeds into the status bar and under the navigation bar. 
- **Contextual Awareness:** The UI always knows what is playing and adapts its entire color scheme to match.

## 26. MusicOS Visual Language
To summarize the visual language to stakeholders: "MusicOS is a glass window looking into a deep, dark room illuminated only by the vibrant colors of the music you are listening to."

## 27. Do's and Don'ts
- **DO** use padding generously to let elements breathe.
- **DON'T** cram information. If a title is too long, use a smooth marquee scroll, do not truncate with ellipses if it's the Now Playing screen.
- **DO** rely on iconography alongside text to aid quick scanning.
- **DON'T** use pure white (`#FFFFFF`) for large surfaces; it breaks the cinematic dark mode.
- **DO** ensure all animations are interruptible (if a user swipes down mid-animation, it reverses naturally).

## 28. Future Expansion
- **Theming Engine:** The strict use of Design Tokens ensures that if MusicOS supports community themes in V2.0, overriding variables (e.g., changing `color-surface-base` to a deep blue) will instantly skin the entire app without breaking contrast ratios.
- **Light Mode:** While V1.0 is dark-only, the semantic naming of surface overlays (Surface 1, 2, 3) allows for a future inversion formula where surfaces get *darker* (or drop shadow based) on a `#F9F9F9` background.
