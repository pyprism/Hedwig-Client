# Hedwig Client [![Tests](https://github.com/pyprism/Hedwig-Client/actions/workflows/ci.yml/badge.svg)](https://github.com/pyprism/Hedwig-Client/actions/workflows/ci.yml) [![codecov](https://codecov.io/gh/pyprism/Hedwig-Client/graph/badge.svg?token=0Ygz7pQoX9)](https://codecov.io/gh/pyprism/Hedwig-Client)

A Flutter based email client for the [Hedwig](https://github.com/pyprism/Hedwig). One codebase across Android, macOS/iOS (unsigned), web, Windows and Linux.

The API base URL is entered at login/registration and persisted — it is not
baked in at build time.

## Develop

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # codegen (drift / freezed / riverpod)
flutter run -d web-server                                    # or any device
```

This stack uses code generation; committed `*.g.dart` / `*.freezed.dart` files
must be regenerated after touching tables, providers, or DTOs (use
`build_runner watch` during active dev).

## Check

```bash
flutter analyze
dart format .
flutter test
```

## Build

```bash
flutter build apk        # Android
flutter build ios        # iOS
flutter build web --release    # Web
flutter build macos      # macOS
flutter build windows    # Windows
flutter build linux      # Linux
```

## CI / Releases

- `.github/workflows/ci.yml` — runs format check, analyze and tests on every
  push/PR to `master`.
- `.github/workflows/release.yml` — on a published GitHub Release, builds
  binaries for all platforms and uploads them to that release.

## Icon Credit
Hedwig icons created by Freepik - Flaticon
[https://www.flaticon.com/free-icon/potter_13717556](https://www.flaticon.com/free-icon/potter_13717556)

## License
MIT
