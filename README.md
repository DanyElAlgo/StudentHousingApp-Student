# student_lib

The **Student** micro-frontend ("microapp") of the Itersapiens Student Housing platform.

`student_lib` packages the entire student-facing experience — browsing rooms, chatting with
owners, managing bookings and profile — as a reusable Flutter package. It is built to work in
two modes:

- **Standalone** — runs as a complete app (its own auth flow, router and theme) for local
  development and testing.
- **Embedded in the shell** — consumed as a git package by the shell app
  ([housing-student-mobile-app](https://github.com/rafael1199v/housing-student-mobile-app.git)),
  which mounts the student routes alongside the householder experience and shares a single
  session, role switcher and locale.

---

## Features

- **Auth** — email/password login and registration, Google sign-in, and automatic session
  restore on launch.
- **Home** — landing dashboard for the signed-in student.
- **Room search** — filter by price range and services, with sorting.
- **Room details** — image carousel, Google Map location, owner card, policies and services,
  booking action, share link, and "chat with owner".
- **Chat** — real-time messaging over SignalR (`/hubs/chat`) with a Drift offline read cache so
  threads remain visible without connectivity.
- **Bookings** — list and status of the student's bookings.
- **Profile** — edit details, change avatar, and switch language (English / Spanish / Portuguese).
- **Deep links** — open a room directly via `studentlib://room/<id>`.

---

## Architecture

The code is organized **feature-first** under `lib/student_app/`:

```
lib/
├── main.dart                     # Standalone entry point (StudentApp + MaterialApp.router)
├── student_experience.dart       # Public surface consumed by the shell (see below)
├── l10n/                         # ARB sources + generated AppLocalizations (en/es/pt)
└── student_app/
    ├── core/                     # config, router, auth service, database, deep links, widgets
    └── features/                 # auth, home, rooms, roomSearch, roomDetails,
                                  #   chat, bookings, profile  (screens/widgets/providers/repository)
```

Key building blocks:

- **State** — [Riverpod](https://riverpod.dev) (`flutter_riverpod` 3).
- **Navigation** — [go_router](https://pub.dev/packages/go_router) with a `StatefulShellRoute`
  for the bottom-nav branches (Home · Chat · Search · Bookings · Profile).
- **Networking** — `dio`, with the client and session provided by `housing_core`.
- **Local cache** — [Drift](https://drift.simonbinder.eu) over SQLite (chat threads, locale).
- **Real-time** — `signalr_netcore` for chat.

Two sibling packages back the microapp (see `pubspec.yaml`):

- **`housing_core`** — framework-agnostic plumbing: session, `SecureTokenStorage`, `DioClient`,
  roles.
- **`housing_design_system`** — shared theme, components and layout primitives.

Both are pinned to git refs and resolved from local clones via `dependency_overrides` during
co-development (remove that block to use the pinned refs).

### The public surface (`student_experience.dart`)

The shell only ever imports `package:student_lib/student_experience.dart`. It exposes exactly:

| Export | Purpose |
| --- | --- |
| `studentExperienceRoutes()` | The list of `RouteBase`s the shell mounts into its own `GoRouter`. |
| `studentInitialLocation` | Default landing route (`/home`). |
| `dioProvider` | Overridden by the shell to inject its shared authenticated Dio/session. |
| `logoutHookProvider` | Filled by the shell to run logout cleanup. `null` when standalone. |
| `changeRoleHookProvider` | Filled by the shell to open its role switcher. `null` when standalone. |
| `localeHookProvider` | Filled by the shell to keep its locale in sync with the student app. |
| `AppLocalizations` | Localization delegates + supported locales for the shell's `MaterialApp`. |

The hook providers default to `null`, so the microapp degrades gracefully when run on its own.

---

## Requirements

- **Flutter / Dart SDK** `^3.11.1`.
- A running **backend** (default `http://localhost:5065`).
- For local co-development, sibling clones next to this repo:
  - `../housing-core`
  - `../proyecto-final-design-system`

  Don't have them checked out? Remove the `dependency_overrides` block in `pubspec.yaml` to pull
  the pinned git refs instead.

---

## Run it standalone

```bash
flutter pub get
flutter run --dart-define=BASE_URL=http://localhost:5065
```

Notes:

- **Localization** is generated automatically on build (`generate: true` in `pubspec.yaml`); run
  `flutter gen-l10n` if you need to regenerate it manually after editing `lib/l10n/*.arb`.
- **Web + Google sign-in** requires a fixed port registered with the OAuth client:

  ```bash
  flutter run -d chrome --web-port 5173
  ```

- **Google Maps & sign-in keys** ship with placeholder values — replace them before running on a
  real environment:
  - Maps key in [web/index.html](web/index.html) and
    [android/app/src/main/AndroidManifest.xml](android/app/src/main/AndroidManifest.xml).
  - `googleWebClientId` in
    [lib/student_app/core/config/app_config.dart](lib/student_app/core/config/app_config.dart).
- **Test a deep link** on a running Android device/emulator:

  ```bash
  adb shell am start -a android.intent.action.VIEW -d "studentlib://room/1"
  ```

---

## Use it in the app shell (as a git package)

The microapp is published from
`https://github.com/DanyElAlgo/StudentHousingApp-Student.git` and consumed by the shell over git.

### 1. Add the dependency

In the shell's `pubspec.yaml`:

```yaml
dependencies:
  student_lib:
    git:
      url: https://github.com/DanyElAlgo/StudentHousingApp-Student.git
      ref: release/1.2.1   # pin a release branch or tag
```

Then `flutter pub get`.

### 2. Wire it into the shell

Import the single public surface and (a) mount the routes, (b) register localization, and
(c) override the hook providers so the student experience shares the shell's session, logout,
role switcher and locale.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_lib/student_experience.dart';

// (a) Mount the student routes into the shell's router.
final shellRouter = GoRouter(
  initialLocation: studentInitialLocation, // '/home'
  routes: [
    // ...the shell's own routes (login, role-aware splash, householder area)...
    ...studentExperienceRoutes(),
  ],
);

void bootstrapShell() {
  runApp(
    ProviderScope(
      // (c) Connect the microapp's hooks to the shell.
      overrides: [
        dioProvider.overrideWithValue(shellDio),            // shared authenticated session
        logoutHookProvider.overrideWithValue(shellLogout),  // void Function()
        changeRoleHookProvider.overrideWithValue(
          (ctx) => getIt<RoleSwitchController>().open(ctx),  // void Function(BuildContext)
        ),
        localeHookProvider.overrideWithValue(shellSetLocale), // void Function(Locale)
      ],
      child: MaterialApp.router(
        routerConfig: shellRouter,
        // (b) Reuse the microapp's localization.
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
      ),
    ),
  );
}
```

> The snippet above is **representative** — it shows how each exported symbol is meant to be wired.
> Adapt the variable names (`shellDio`, `shellLogout`, etc.) to the shell's own implementation.

Leaving any hook un-overridden is safe: it falls back to its standalone default (`null` /
no-op).

---

## Configuration reference

| What | Where | Default / value |
| --- | --- | --- |
| Backend base URL | `--dart-define=BASE_URL=...` → `AppConfig.apiBaseUrl` | `http://localhost:5065` |
| Google Maps key | `web/index.html`, `android/app/src/main/AndroidManifest.xml` | placeholder (replace) |
| Google web client ID | `AppConfig.googleWebClientId` | placeholder (replace) |
| Web dev port (Google sign-in) | `flutter run -d chrome --web-port 5173` | `5173` |
| Deep-link scheme | `AppConfig` / `room_deeplink.dart` | `studentlib://room/<id>` |
| Student role | `AppConfig.studentRole` | `Student` |

`BASE_URL` feeds media URLs and the SignalR chat hub (`<BASE_URL>/hubs/chat`); the Dio HTTP client
itself is provided by `housing_core`.

---

## Related repositories

- **This microapp:** https://github.com/DanyElAlgo/StudentHousingApp-Student.git
- **Shell app (householder + shell):** https://github.com/rafael1199v/housing-student-mobile-app.git
- **Core (shared plumbing):** https://github.com/rafael1199v/housing-core-mobile.git
- **Design system:** https://github.com/rafael1199v/housing-design-system.git
- **Backend:** https://github.com/rafael1199v/housing-student-app.git
