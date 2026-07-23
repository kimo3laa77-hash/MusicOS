# MusicOS - Information Architecture (IA)

## 1. App Hierarchy
The MusicOS architecture follows a strictly nested, shell-based hierarchy. The application is divided into two primary contexts: the **Shell Context** and the **Modal Context**.

- **Root (Application Entry)**
  - Splash Screen -> Initialization (Database checks, Permission checks)
  - **Onboarding Context** (If no music folders are mapped)
    - Welcome Screen
    - Storage Access Framework (SAF) Picker
  - **Shell Context** (Main authenticated/configured state)
    - **Shell Router:** Houses the persistent Bottom Navigation Bar and the persistent Mini Player.
    - **Feature Branches:** The four primary pillars of the app (Home, Search, Library, Settings).
  - **Modal Context** (Global Overlays)
    - Full-Screen Now Playing Player
    - Contextual Bottom Sheets (Options, Queue Management)
    - System Dialogs

## 2. Navigation Hierarchy
Navigation is driven by a Declarative Router utilizing a **Nested Navigation (ShellRoute)** pattern. 
- **The Shell** acts as the parent container. It is responsible for drawing the Bottom Navigation Bar and the Mini Player. 
- **The Branches** act as independent navigation stacks. Navigating deeper into a branch (e.g., Library -> Album Detail) does *not* replace the Shell; the Bottom Navigation and Mini Player remain visible and interactive.
- **Global Routes** (like the Full Player) are pushed *above* the Shell, temporarily obscuring the Bottom Navigation.

## 3. Screen Hierarchy
A detailed structural breakdown of all core screens in Version 1.0:

- **1.0 Home (Dashboard)**
  - 1.1 Recently Added (Horizontal Scroll)
  - 1.2 Continue Listening (Contextual Card)
  - 1.3 Pinned Items (Grid)
- **2.0 Search**
  - 2.1 Search Input (Header)
  - 2.2 Top Results (Instant Preview)
  - 2.3 Categorized Results (Songs, Albums, Artists, Folders)
- **3.0 Library**
  - 3.1 Library Navigation Tabs (Playlists | Artists | Albums | Songs | Genres | Folders)
  - **3.2 Sub-Screens (Detail Views)**
    - 3.2.1 Playlist Detail (Tracklist)
    - 3.2.2 Artist Detail (Hero Image -> Top Tracks -> Albums Grid)
    - 3.2.3 Album Detail (Cover Art -> Tracklist -> Info)
    - 3.2.4 Folder Detail (Filesystem traversal)
- **4.0 Settings**
  - 4.1 General (Theme, Language)
  - 4.2 Library (Manage Folders, Rescan)
  - 4.3 Playback (Gapless, Sleep Timer)
  - 4.4 Advanced (Backup/Restore, Logs)

## 4. Bottom Navigation
The primary mechanism for navigating the Shell Context. Contains exactly four destinations to maintain cognitive ease.
1. **Home:** The dynamic dashboard for quick resumption.
2. **Search:** Global query input for instant discovery.
3. **Library:** The user's collection, categorized and filterable.
4. **Settings:** App configuration and maintenance.

*Rule:* The Bottom Navigation must never exceed 5 tabs (currently 4) to ensure touch targets remain large, ergonomic, and accessible on all screen sizes.

## 5. Screen Relationships
Information in MusicOS is highly interconnected. The IA relies on contextual linking rather than strict top-down navigation.
- **Cross-linking:** 
  - Tapping an Artist's name on a Song tile inside a Playlist Detail screen immediately pushes the Artist Detail screen onto the current navigation stack.
  - Tapping an Album cover inside the Home Dashboard pushes the Album Detail screen.
- **Independence:** Detail screens must be capable of receiving a unique identifier (e.g., `albumId`) and fetching their own data from the Isar database, rather than relying on complex, heavy data payloads passed from the previous screen.

## 6. Modal Hierarchy
Modals (specifically Bottom Sheets) are used for contextual, non-destructive actions that do not warrant a full screen change.
- **Track Context Menu:** (Play Next, Add to Queue, Go to Album, Go to Artist).
- **Album/Artist Context Menu:** (Play Next, Add to Queue, Pin to Home).
- **Queue Manager:** A dynamic bottom sheet invoked from the Full Player to view, reorder (drag-and-drop), and remove upcoming tracks.

## 7. Dialog Hierarchy
Dialogs (Center pop-ups) are strictly reserved for blocking interactions:
- **Destructive Actions:** "Are you sure you want to clear the entire queue?" or "Remove this folder from library?"
- **System Permissions:** Explaining why Storage permissions are needed before invoking the OS prompt.
- **Critical Errors:** "Database corrupted. Please restore from backup or reset."

## 8. Mini Player Behavior
The Mini Player is a persistent UI component anchored immediately above the Bottom Navigation Bar.
- **Visibility:** It is visible globally across all tabs as long as the Audio Queue is not empty.
- **Interactions:**
  - **Tap:** Expands the Mini Player into the Full Player (Now Playing screen).
  - **Swipe Up:** Expands into the Full Player.
  - **Swipe Left/Right:** Skips to the next/previous track with a fluid gesture.
  - **Play/Pause Button:** Toggles playback state instantly.
- **Z-Index:** Always sits above the scrolling content of the Shell, but below Modals and Dialogs.

## 9. Full Player Behavior (Now Playing)
The core immersion screen.
- **Entry:** Invoked exclusively by interacting with the Mini Player.
- **Exit:** Dismissed via a top-left chevron button or a physical downward swipe gesture on the album art or header.
- **Z-Index:** Pushed as a full-screen modal over the entire application, completely obscuring the Bottom Navigation Bar to maximize visual focus on the music.
- **Hierarchy within Player:**
  - Main View: Album Art, Seek Bar, Transport Controls.
  - Secondary View (Overlay/Sheet): The "Up Next" Queue, invoked via a dedicated button in the transport row.

## 10. Navigation Rules
- **State Preservation (Tab Persistence):** If a user is on the Library tab, scrolls down 500 rows, switches to the Home tab, and switches back to the Library tab, their exact scroll position and current navigation stack (e.g., looking at an Album Detail) MUST be perfectly preserved.
- **Back Button (Android Native/Gesture):** 
  - Pressing back pops the current stack. 
  - If the stack is at the root of a tab (e.g., root of Library), pressing back switches focus to the Home tab. 
  - If already on the Home tab, pressing back sends the app to the background.
- **Full Player Back Action:** The back gesture while the Full Player is open simply dismisses the player, returning the user to exactly where they were in the Shell.

## 11. Deep Linking Strategy
Every distinct view in the application must be strictly addressable via a URI. This is critical for future features like Android widgets, app shortcuts, and Android Auto integration.
- **Format:** `musicos://[domain]/[id]`
- **Examples:**
  - `musicos://home`
  - `musicos://album/8472`
  - `musicos://artist/992`
  - `musicos://search?q=pink+floyd`
  - `musicos://player`
- **Routing Logic:** When a deep link is fired, the router resolves the path, ensures the Shell is constructed, and pushes the correct Detail Screen onto the appropriate tab's navigation stack, gracefully handling invalid IDs.

## 12. Future Scalability
The Information Architecture is intentionally designed to absorb the V1.1, V1.2, and V2.0 roadmap without requiring a structural refactor.
- **Adding Streaming Providers (V2.0):** A YouTube Music integration will *not* add a new tab. Instead, the global Search will query both local and YouTube sources simultaneously. The Library tab will simply display remote albums alongside local albums, distinguished by an icon. The IA normalizes all entities.
- **Adding Smart Playlists (V1.2):** These simply become new tiles inside the existing `3.0 Library` hierarchy.
- **Adding Lyrics (V2.0):** Will be integrated as a tertiary view inside the `9.0 Full Player Behavior`, toggleable via a button that replaces the Album Art with a scrolling, synced lyrics view.
