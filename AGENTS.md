# Repository Guidelines

This repo contains a SwiftUI iOS app that handles Firebase-backed authentication flows. Follow the guidance below to keep changes predictable and easy to review.

## Project Structure & Module Organization
- `Modern-Sign-In-Up/App`: App entry point (`Modern_Sign_In_UpApp`) and environment wiring.
- `Core/Root`: `ContentView` decides between auth and profile flows.
- `Core/Authentication`: `AuthViewModel` plus `LoginView` and `RegistrationView` screens.
- `Core/Profile`: Authenticated profile screen and account actions.
- `Components`: Reusable UI pieces (`ForumField`, `SettingsRow`, `LoadingView`).
- `Model`: Shared models (e.g., `User`).
- `Assets.xcassets` and `Preview Content`: Design assets and preview data.
- `Modern-Sign-In-Up.xcodeproj`, `GoogleService-Info.plist`: Xcode project and Firebase config (keep project-specific; avoid sharing secrets).

## Build, Test, and Development Commands
- Open the project: `open Modern-Sign-In-Up.xcodeproj` (or double-click in Finder).
- Build in Xcode: select a simulator/device and press `Cmd+B`; run with `Cmd+R` to launch the app.
- CLI build (headless): `xcodebuild -project Modern-Sign-In-Up.xcodeproj -scheme Modern-Sign-In-Up -destination "platform=iOS Simulator,name=iPhone 15" build`.
- Firebase requires a valid `GoogleService-Info.plist` in the project root; use test credentials only.

## Coding Style & Naming Conventions
- Swift 5 + SwiftUI; use 4-space indentation and keep lines readable (<120 chars).
- Types and views are `PascalCase` with suffixes (`ProfileView`, `AuthViewModel`); properties and functions are `camelCase`.
- Use `@MainActor` for view models touching UI state and wrap async calls in `Task {}` from views.
- Keep views small and compose via `Components`; prefer passing bindings instead of singletons.

## Testing Guidelines
- No test target exists yet; add an XCTest target for new logic and run with `Product > Test (Cmd+U)` or `xcodebuild ... test`.
- Use SwiftUI previews for quick UI validation and layout checks.
- Manual checks per change: sign in, sign up, sign out, and delete account; confirm loading overlays and errors show correctly.

## Commit & Pull Request Guidelines
- Commits: imperative, concise summaries (e.g., `[auth] Handle delete account errors`), keep to ~72 characters.
- PRs: describe the feature/fix, risks, and test steps (simulator/device used). Attach screenshots or short clips for UI changes and note any Firebase/config needs.
- Reference related issues or tasks directly in the PR description.

## Security & Configuration Tips
- Never commit real credentials or user data; use Firebase test projects.
- Keep environment-specific values in local `.plist`/`.xcconfig` files and avoid hardcoding secrets in Swift files.
- Validate auth flows with throwaway accounts and revoke them after testing.
