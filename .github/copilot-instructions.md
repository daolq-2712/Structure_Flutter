<!-- .github/copilot-instructions.md - guidance for AI coding agents working on Structure_Flutter -->

This repository is a small Flutter application used for training. The notes below are aimed at helping an AI coding agent become productive quickly in this specific codebase.

Essentials
- Project type: Flutter mobile app (Android & iOS). See `pubspec.yaml` and `lib/main.dart`.
- Package name (Android): `com.sun.structureflutter` (see `android/app/src/main/kotlin/.../MainActivity.kt`).
- Linting: uses `package:flutter_lints` and `analysis_options.yaml` rules.

Big-picture architecture
- Single-app Flutter project with the entry point at `lib/main.dart`.
- Native shells are under `android/` and `ios/` created by Flutter tooling; most logic belongs in `lib/`.
- No networking, backend, or platform channels are present in the current tree — changes should primarily target Flutter/Dart code in `lib/` unless adding new integrations.

Developer workflows & commands
- Common local commands (run from repo root):
  - Run on an attached device or emulator: `flutter run` (uses `lib/main.dart`).
  - Build Android APK: `flutter build apk`.
  - Build iOS (macOS): `flutter build ios`.
  - Run analyzer (lints & static analysis): `flutter analyze`.
  - Run widget tests: `flutter test` or the specific test file under `test/`.

Project-specific conventions and patterns
- Keep UI logic inside `lib/` and prefer small widgets. The app currently uses a single StatefulWidget in `lib/main.dart`.
- Follow the existing analysis rules in `analysis_options.yaml` (based on `flutter_lints`). Use `// ignore:` only when necessary and add a short justification.
- Android package id and Kotlin MainActivity file should not be renamed without updating Gradle configs and iOS bundle identifiers.

Integration points & files to reference
- Entry point: `lib/main.dart` (root widget `MyApp`).
- Android native entry: `android/app/src/main/kotlin/com/sun/structureflutter/MainActivity.kt`.
- iOS native entry: `ios/Runner/AppDelegate.swift` and `ios/Runner/Info.plist`.
- Build config: `pubspec.yaml` (dependencies & version), `android/build.gradle`, and `android/gradle/wrapper/gradle-wrapper.properties`.

Examples (copy/paste-ready)
- Add a new widget file: create `lib/src/widgets/my_widget.dart` and export it from `lib/src/widgets.dart`.
- Quick hot-reload during development: run `flutter run` and save `lib/` files to apply hot reload.

When proposing changes
- Keep diffs small and focused. For UI changes, include screenshots or describe visual expectations.
- Update `pubspec.yaml` if adding a package, and run `flutter pub get` locally; add the package version rather than `any`.
- If modifying native Android/iOS files, include clear instructions to run platform builds (Android Studio/Xcode), since CI may not run those steps automatically.

Quality gates
- Ensure `flutter analyze` is clean (no new analyzer errors). Prefer addressing lint warnings; if not possible, document why.
- Run `flutter test` for changes that affect behavior.

Open questions for maintainers
- Are there any preferred folder structures under `lib/` (features vs. modules)? The repo currently has only `lib/main.dart`.
- Is there a CI pipeline or target devices/emulator versions we should follow? (No CI config found in repo.)

If anything here is unclear or you'd like extra detail (examples for tests, widget structure, or CI templates), tell me which area to expand.
