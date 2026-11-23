# EQ-RSS Reader — Windows port

Windows desktop port of the existing KDE Plasma 6 EQ-RSS Reader. The port keeps the original QML feed-management and reading logic and replaces KDE/Plasma integration with Qt Quick Controls, a native Windows window, a Windows notification-area (system tray) icon, and Windows settings.

## Current port scope

- Preserves the original RSS/Atom feed logic, feed and group management, filtering, article sorting, reader/original-page modes, incremental loading, refresh controls, and the original Qt Quick LocalStorage database schema and database name.
- Keeps the original `main.qml` logic in `qml/Main.qml` with only platform-integration and theme changes.
- Replaces Plasma Components with Qt Quick Controls 2 and Kirigami theme/icon APIs with Windows palette values and a small Segoe MDL2 icon adapter.
- Adds a system-tray icon. Single-click/double-click toggles the window; the tray menu offers Open and Exit. Closing the window hides it instead of exiting.
- Adds settings for refresh interval, responsive-reader threshold, and optional Windows startup.
- Keeps application data in the user's Windows application-data directory. RSS database data is stored by Qt Quick LocalStorage under the Qt engine's offline-storage directory.

`Storage.js` was not copied: the uploaded source's `main.qml` does not import or call it. The active persistence implementation is `QtQuick.LocalStorage` directly in `main.qml`.

## Build locally on Windows

Requirements:

- Windows 10 (1809+) or Windows 11, x64
- Qt 6.8.3 for MSVC 2022 64-bit, including the Qt WebEngine module
- Visual Studio 2022 C++ build tools
- CMake 3.24+

From a Qt 6.8.3 MSVC 2022 developer command prompt:

```powershell
cmake -S . -B build -G "Visual Studio 17 2022" -A x64
cmake --build build --config Release --parallel

New-Item -ItemType Directory -Force package | Out-Null
Copy-Item build/Release/EQ-RSS-Reader.exe package/
windeployqt --release --qmldir qml --dir package package/EQ-RSS-Reader.exe
```

The `windeployqt` step collects Qt runtime libraries, plugins and QML imports. Qt WebEngine also needs its helper process and resource files; the deployment tool is intended to collect these. Test the packaged folder on a clean Windows machine before publishing it.

## GitHub Actions: automatic Windows build

The workflow is already included at `.github/workflows/windows-build.yml`.

1. Create a new repository on GitHub named `EQ-RSS-Reader` (or another name you prefer).
2. Set it to **Public** if you want the source code to remain open source, as discussed. The workflow does not require secrets.
3. Do not initialize the repository with a README or license if you are going to push this prepared folder; it already contains both.
4. Extract this project ZIP on your computer.
5. Open a terminal in the extracted `EQ-RSS-Reader-Windows` folder and run:

```bash
git init
git add .
git commit -m "Initial Windows port of EQ-RSS Reader"
git branch -M main
git remote add origin https://github.com/YOUR-GITHUB-USERNAME/EQ-RSS-Reader.git
git push -u origin main
```

6. On GitHub, open the repository's **Actions** tab. The workflow named **Build EQ-RSS Reader for Windows** starts automatically after the push.
7. Open the completed workflow run. Under **Artifacts**, download `EQ-RSS-Reader-Windows-x64`.
8. Extract the ZIP and run `EQ-RSS-Reader.exe`.

Every later push to `main` starts another build. You can also start one manually from **Actions → Build EQ-RSS Reader for Windows → Run workflow**.

## Important testing status

This source package was prepared and statically reviewed in the Linux working environment. A Windows Qt/MSVC toolchain was not available here, so a real Windows compile and runtime test have **not** yet been performed. The first GitHub Actions run is therefore the first full compiler validation. If it reports an error, send me the complete Actions build log and we can correct it before treating the Windows port as release-ready.

Before publishing a release, test at least: first launch, add RSS and Atom feeds, discover feeds from a website, create/edit/delete groups, switch filters, open Reader Mode and original website, manual/full/automatic refresh, close-to-tray behavior, restart persistence, and Windows startup toggle.

## License

This project is distributed under **GNU GPL version 3 or later**, matching the license declared in the supplied KDE source package. Qt and Qt WebEngine are third-party components and retain their respective licenses. See `LICENSE` and `THIRD_PARTY_NOTICES.md`.


## Windows installer

GitHub Actions builds `EQ-RSS-Reader-Setup.exe` with Inno Setup, as well as a portable ZIP package. See `GITHUB-UPUTSTVO.md`.
