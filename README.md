# Firebase Auth + SwiftUI Template

I built this because I got tired of setting up the same login and signup flows for every new app idea. This is a clean, SwiftUI authentication template that integrates Firebase authentication, keeps user data in sync, and includes the small but essential details that make an app feel complete and polished. It’s designed to be dropped into any new project so you can focus on building what actually matters.


## 💡 The Idea
Most "how-to" guides leave you with a half-baked login screen. This template is meant to be a solid starting point that actually feels like a real app. It handles:
* **User Sync**: Maps Firebase Auth users directly to a Firestore `users` collection.
* **Smart Loading**: A global `LoadingView` that actually tells the user what's happening (e.g., "Deleting account..." vs "Signing in...").
* **Safe Deletion**: A proper re-authentication flow so users can’t accidentally delete their account without confirming their password.

## 🛠 What's Under the Hood?
* **MVVM Architecture**: Keeping the logic in the ViewModel so the Views stay light and readable.
* **Async/Await**: No messy completion handlers. Everything is built with modern Swift concurrency.
* **State-Driven UI**: The app reacts automatically when the user signs in or out.
* **Reusable Components**: Clean, modular SwiftUI views for inputs and rows that you can reuse anywhere.



## 🚀 Quick Setup
1. **Firebase**: Create a project in the console, enable Email/Password auth, and turn on Firestore.
2. **The Plist**: Download your `GoogleService-Info.plist` and drag it into the root of the Xcode project.
3. **Firestore Rules**: Make sure your rules allow users to read/write only their own document:
   ```javascript
   allow read, write: if request.auth != nil && request.auth.uid == userId;
