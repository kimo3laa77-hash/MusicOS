# MusicOS - Product Requirements Document (PRD)

## 1. Product Overview
MusicOS is a premium, local-first music platform designed for audio enthusiasts. It aims to provide the visual elegance of top-tier streaming services (like Apple Music or Spotify) while catering exclusively to large, locally stored music libraries. Every feature is evaluated against a single core philosophy: *"Does this make listening to music more enjoyable?"*

**Target Release:** Version 1.0

## 2. Platforms & Architecture
- **Initial Target:** Android exclusively (V1.0).
- **Future-Proofing:** Architecture must be strictly platform-independent to allow future expansion to iOS, Windows, macOS, and Linux without rewriting business logic. Web support is strictly excluded.
- **Responsiveness:** Mobile-First design, but fully responsive. UI must automatically scale for small phones, large phones, foldables, and tablets using relative dimensions (no fixed widths, heights, or hardcoded paddings).
- **Localization:** English only for V1.0, but the architecture must natively support Internationalization (i18n) and Right-to-Left (RTL) layouts from day one.

## 3. Design & User Experience
- **Theme:** AMOLED Dark Mode is the *only* default experience for V1.0. Light Mode will not exist.
- **Color Palette:** Deep Black, Deep Purple, and dynamic colors extracted directly from album artwork.
- **Aesthetic:** Cinematic, elegant, and modern. Heavy use of glassmorphism, blur, dynamic gradients, soft shadows, and smooth micro-animations.
- **Iconography:** Rounded, minimal, consistent, Material 3 inspired. No skeuomorphic or overly colorful icons.
- **UX Principles:** One tap to music, zero friction, instant feedback, seamless screen transitions, and absolute predictability. Playback responsiveness always wins over UI animations.

## 4. Supported Audio Formats
- **Mandatory (V1.0):** MP3, FLAC, WAV, AAC, M4A, OGG Vorbis, OPUS.
- **Future Support:** ALAC, AIFF.
- **Out of Scope:** DSD, SACD, WMA, APE.
- *Requirement:* The architecture must allow adding new audio decoders later without modifying the core player architecture.

## 5. Library Management & Ingestion
- **Discovery Strategy:** 
  - On first launch, the user manually selects root music folder(s) using the Android Storage Access Framework. 
  - The app will *never* aggressively scan the entire device automatically (to preserve battery and privacy).
  - After selection, MusicOS silently watches these folders for changes and updates the library automatically without requiring manual refreshes.
- **Metadata Handling:**
  - Read-only approach. MusicOS will *never* modify or write to the user's original music files.
  - Read tags: Title, Artist, Album, Album Artist, Genre, Track Number, Disc Number, Year, Composer, Embedded Artwork, Embedded Lyrics.
  - Missing metadata falls back to premium, auto-generated placeholders (e.g., "Unknown Artist", default artwork).
- **Artwork Caching:**
  - Multi-level cache (Memory -> Disk -> Original Artwork).
  - Images are automatically resized for context (e.g., 64x64 for Mini Player, 128x128 for Lists, 512x512 for Now Playing).
  - Full-resolution artwork is never loaded into lists to prevent Out-Of-Memory errors. Users can clear the cache manually.

## 6. Player & Audio Engine
- **Gapless Playback:** Mandatory for V1.0. This is a non-negotiable requirement.
- **Equalizer:** V1.0 relies on the native Android Audio Effects API. MusicOS will provide an "Open System Equalizer" option. The architecture must not depend directly on this implementation, allowing a custom DSP to be slotted in later.
- **Queue Behavior:** 
  - Default action: Tapping a song inside an album immediately replaces the temporary queue with the album and plays the song.
  - Secondary actions: Play Next, Add to Queue, Play Last, Add to Playlist.
  - Queue editing supports Drag & Drop, Remove, Reorder, and Clear Queue.
- **State Persistence:** The app must remember the exact current track, queue, playback position, shuffle/repeat states, playback speed, and sleep timer even if completely terminated by the OS.
- **Background Service:** 
  - A foreground service runs while playback is active. 
  - When paused, a configurable timeout (e.g., 5-10 minutes) keeps the session alive. After the timeout, the service is released to save battery, but the complete state is persisted for instant restoration.

## 7. Search, Discovery & Navigation
- **Home Dashboard:** The initial screen is a premium, dynamic dashboard. Sections include: Continue Listening, Recently Played, Recently Added, Pinned Albums/Artists, Favorite Playlists, Quick Actions, and Storage Status.
- **Search Depth:** Universal, instant local search across Song Title, Artist, Album, Album Artist, Genre, Composer, Year, Track/Disc Number, File Name, and Folder Name. Supports typo tolerance and partial matches.
- **Search UX:** Hybrid presentation showing a "Top Result" followed by categorized preview lists (Songs, Albums, Artists, Folders), with the ability to expand ("See All") and apply quick filters.
- **Library Sorting:** Fast Scroll A-Z index, Alphabet Jump, Instant Scroll Position, Sticky Headers. 
- **Folder Browser:** Mandatory feature. Users must be able to browse their raw filesystem folders and transition between folders and metadata views seamlessly.

## 8. Data Management & Settings
- **User Data Storage:** All application data (Favorites, Play counts, History, Custom Playlists) lives exclusively inside the internal MusicOS database.
- **Backup & Restore:** Mandatory V1.0 feature. Users must be able to export and restore their entire profile (excluding audio files) to a versioned, future-proof format (JSON/ZIP) to ensure data is never lost.
- **Settings Hierarchy:**
  - *General:* Theme, AMOLED mode, dynamic colors, accent style, language.
  - *Library:* Manage folders, rescan, ignore hidden files, artwork cache management.
  - *Playback:* Gapless toggle, audio focus, resume playback, playback speed, sleep timer, open system EQ.
  - *Performance:* Cache size limits, memory usage tweaks, battery optimization.
  - *Developer (Advanced):* Logs, diagnostics, database info.

## 9. Future-Proofing & Out of Scope for V1.0
- **Plugin Architecture:** The architecture must utilize a Provider Pattern to support future integrations (YouTube Music, Spotify, ListenBrainz, Last.fm scrobbling, Lyrics scraping) without rewriting the UI or core search architecture.
- **Out of Scope for V1.0:** External playlist import (M3U/PLS), crossfade, replay gain, DSP effects, network streaming, social features, cloud sync, Light Mode.

## 10. Functional Requirements
### F-01: Audio Playback Engine
- **Description:** Headless background audio decoding with true gapless transitions.
- **Priority:** Critical
- **Dependencies:** Android MediaCodec, AudioTrack.
- **Acceptance Criteria:** Plays all supported formats (FLAC/MP3/M4A/etc.) without silence between sequential tracks on the same album. Service survives app swipe-away.

### F-02: Library Scanner
- **Description:** Index metadata and artwork from user-selected SAF folders.
- **Priority:** Critical
- **Dependencies:** Android SAF, Isar Database.
- **Acceptance Criteria:** Successfully reads massive file structures (50,000+ files) into the database. Falls back gracefully on missing tags. Updates silently when local file changes are detected.

### F-03: Queue Management
- **Description:** Advanced state machine managing "Up Next" tracks.
- **Priority:** High
- **Dependencies:** None (Pure domain logic).
- **Acceptance Criteria:** Correctly handles "Play Next" and "Add to Queue". Remembers full state after complete app termination. Shuffle and Repeat algorithms behave predictably.

### F-04: User Data Backup
- **Description:** Export and import MusicOS internal data to a portable file.
- **Priority:** High
- **Dependencies:** Local File System.
- **Acceptance Criteria:** Produces a `.zip` or `.json` containing favorites, play counts, playlists. Can be successfully restored on a fresh install without data loss.

## 11. Complete Screen Specification
### S-01: Home Dashboard
- **Purpose:** Provide immediate access to current listening contexts and new additions.
- **Components:** Greeting, "Continue Listening" card, horizontal scroll rows for "Recently Added", "Pinned Artists". Persistent mini-player at the bottom.
- **Interactions:** Tap row item to play immediately. Long press for context menu.
- **Navigation:** Bottom nav bar to Search, Library, Settings.
- **Empty State:** "Welcome to MusicOS. Tap here to select your music folder."
- **Loading State:** Premium shimmering skeleton rows.
- **Error State:** N/A (Offline first).
- **Future Improvements:** AI-generated "Suggested for You" row.

### S-02: Now Playing Screen
- **Purpose:** Full-screen immersion for the currently active track.
- **Components:** Large high-res artwork, fluid background gradient matching artwork, seek bar, Play/Pause, Next, Prev, Shuffle, Repeat, Queue toggle, 3-dot context menu.
- **Interactions:** Swipe artwork horizontally to change tracks. Swipe down to collapse back to mini-player. Tap seek bar to jump.
- **Navigation:** Modal full-screen cover over any other screen.
- **Empty State:** Only accessible when a queue exists.
- **Loading State:** Instant render using cached memory artwork.
- **Error State:** "Audio Error: Format unsupported" overlay message.
- **Future Improvements:** Synced lyrics overlay (LRC).

### S-03: Library View (Albums/Artists/Tracks)
- **Purpose:** Display the entire indexed collection seamlessly.
- **Components:** Filter chips, dynamic sorting header, grid/list toggle, A-Z fast scroller on the right edge.
- **Interactions:** Scroll, tap to open details, long press to select multiple.
- **Navigation:** Pushed onto the main navigation stack.
- **Empty State:** "No albums found in your library."
- **Loading State:** Skeleton tiles mimicking standard list dimensions.
- **Error State:** "Database error. Please rescan."
- **Future Improvements:** Custom grid sizing via pinch-to-zoom.

### S-04: Folder Browser
- **Purpose:** Raw filesystem navigation for power users.
- **Components:** Breadcrumb trail header, list of directory and file tiles.
- **Interactions:** Tap folder to navigate down, tap file to play, tap breadcrumb to jump up.
- **Empty State:** "Folder is empty."

## 12. Complete User Flows
### UF-01: First Launch & Onboarding
1. User installs and opens MusicOS.
2. Splash screen transitions to a premium Welcome screen.
3. User taps "Select Music Folder".
4. OS-level Storage Access Framework (SAF) picker opens.
5. User selects `SD Card/Music` and grants permission.
6. App transitions to Home Dashboard; a non-blocking progress bar shows indexing status.
7. Library populates dynamically as indexing occurs in the background.

### UF-02: Play Music & Queue Manipulation
1. User taps an Album cover in the Library.
2. User taps Track 1.
3. Queue is cleared and replaced with the Album (starting at Track 1). Mini-player appears.
4. User taps Mini-player; Now Playing screen expands seamlessly.
5. User swipes down to return to Library.
6. User long-presses Track 5 and selects "Play Next". Track 5 is inserted securely into index 1 of the queue.

### UF-03: Search Music
1. User taps the Search icon in the bottom navigation.
2. User begins typing "Pink". 
3. UI instantly reveals a "Top Result" (Pink Floyd - Artist) and horizontal lists for matching Songs, Albums, and Folders.
4. User taps "Albums" chip to filter out other categories.
5. User selects an album to view its tracklist.

### UF-04: Backup & Restore
1. User navigates to Settings > Advanced > Backup Data.
2. OS file picker prompts for a save location.
3. User selects `Downloads`. MusicOS safely writes `musicos_backup.zip`.
4. *(New Device):* User installs app, skips folder selection, goes to Settings > Restore Data.
5. User selects `.zip` file. Database is restored, and user is prompted to remap their primary music root folder.

## 13. Performance Requirements
- **Startup Time:** < 1.0 second from cold boot to interactive UI.
- **Search Latency:** < 50ms for complex queries on a 50,000 track library (powered by Isar).
- **Scrolling FPS:** Locked 60fps (or 120fps on supported displays) during heavy list/grid scrolling. Zero dropped frames.
- **Artwork Loading:** < 100ms from memory cache to screen render. Zero visible pop-in for recycled list views.
- **Database Queries:** Sub-20ms execution time. All heavy database logic must run on background isolates.
- **Memory Usage:** Application footprint must remain under a strict ceiling. Artwork cache is strictly size-bound.
- **Battery Usage:** Audio background service must drain less than 2% battery per hour of continuous playback (screen off).

## 14. Android Requirements
- **Permissions:** 
  - `READ_MEDIA_AUDIO` (Android 13+).
  - `READ_EXTERNAL_STORAGE` (Legacy devices).
  - `FOREGROUND_SERVICE` and `FOREGROUND_SERVICE_MEDIA_PLAYBACK` (Android 14+).
  - `POST_NOTIFICATIONS` (For the persistent media player).
- **MediaSessionCompat:** Full integration required. Lock screen controls, smartwatch controls, and Android Auto must interface natively with the app's player.
- **Audio Focus:** Must implement `AudioManager` correctly. Duck volume for GPS nav; pause for phone calls; resume automatically when focus is regained.
- **Hardware Integrations:** Respect `ACTION_AUDIO_BECOMING_NOISY` (pause immediately when wired/Bluetooth headphones disconnect). Map Bluetooth media buttons directly to the Audio Engine.

## 15. Non Functional Requirements
- **Reliability:** 99.9% crash-free session rate. The Audio Engine must be fault-tolerant against corrupted media files.
- **Availability / Offline First:** 100% of V1.0 features must work in airplane mode. Network requests are prohibited in V1.0.
- **Scalability:** The database schema and UI pagination must seamlessly handle edge-case users with 100,000+ local files without degrading performance.
- **Maintainability:** Codebase must adhere strictly to Feature-First Clean Architecture. Zero technical debt by design. Complete separation between UI (Presentation), Domain, and Data layers.
- **Accessibility:** Fully compatible with Android TalkBack. WCAG AA contrast ratios respected even when extracting dynamic colors. Responsive OS-level font scaling is mandatory.
- **Security & Privacy:** Zero telemetry or analytics out-of-the-box. User data never leaves the device.

## 16. Future Roadmap
### Version 1.1 (The Refinement Update)
- External Playlist Import/Export (M3U, PLS).
- Audio Crossfade support.
- Custom Sleep Timer duration (beyond presets).
- Expanded sorting and grouping options.

### Version 1.2 (The DSP Update)
- Custom Parametric Equalizer.
- ReplayGain / Loudness Normalization.
- Smart Playlists (Auto-generated based on rules like play counts).

### Version 2.0 (The Platform Update)
- Plugin System introduction (YouTube Music, Spotify integrations).
- Lyric fetching (LRC) and synced UI display.
- Multi-device Cloud Sync (optional opt-in).
- Dedicated Desktop (Windows/macOS) releases.

## 17. MVP Definition (Minimum Viable Product for V1.0)
The following features **MUST** exist and be bug-free before V1.0 can ship to production:
1. Complete Storage Access Framework (SAF) integration for folder watching.
2. Perfect Gapless Playback for FLAC and MP3.
3. Stable Foreground Service and MediaSession integration (survives app kill).
4. Responsive Home, Library, and Now Playing screens.
5. Instant Search architecture.
6. JSON/ZIP Backup and Restore functionality.
*If any of these 6 pillars are incomplete, the product is not ready for launch.*

## 18. Risks
- **Technical Risks:** Achieving true gapless playback on heavily modified Android vendor ROMs (e.g., MIUI, ColorOS) can be erratic. Requires extensive testing across Samsung, Pixel, and Chinese OEMs.
- **Performance Risks:** Aggressive OS battery managers killing the foreground service after the 10-minute pause timeout, potentially causing state loss if persistence fails.
- **UX Risks:** Users migrating from traditional apps might find SAF folder selection cumbersome compared to aggressive auto-scanning. Onboarding UI must clearly explain *why* this is better for privacy and battery.
- **Future Risks:** Evolving Android Scoped Storage APIs may force refactoring of the file watcher logic in future API levels.

## 19. Glossary
- **SAF (Storage Access Framework):** Android's privacy-focused file picker API, ensuring apps only access user-approved directories.
- **Isar:** A highly optimized NoSQL local database used for the app's internal metadata and user data.
- **Gapless Playback:** Sequential playback of tracks with absolutely zero milliseconds of silence injected between them.
- **MediaSession:** The Android OS bridge that allows the lock screen, wearables, and Bluetooth devices to control the app's audio.
- **Glassmorphism:** A UI design style utilizing frosted glass aesthetics (background blur and translucency) to create depth.
- **OOM (Out Of Memory):** A fatal app crash caused by exhausting the device's RAM, typically due to improper image caching.
- **Provider Pattern:** A software design pattern used to decouple the UI from the data source, allowing future swapping (e.g., LocalProvider vs YouTubeProvider).
