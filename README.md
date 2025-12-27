# Firebase Auth + SwiftUI Template

I built this because I got tired of setting up the same login and signup flows for every new app idea. This is a clean, SwiftUI authentication template that integrates Firebase authentication, keeps user data in sync, and includes the small but essential details that make an app feel complete and polished.

It’s designed to be dropped into any new project so you can focus on building what actually matters.


## 💡 The Idea

Most “how-to” guides leave you with a half-baked login screen. This template is meant to be a solid starting point that actually feels like a real app. It handles:

- Firebase Auth synced cleanly to Firestore  
- Clear, global loading states that explain what’s happening  
- Safe account deletion with re-authentication  

Built with **modern SwiftUI best practices**:
- MVVM architecture  
- Async/await concurrency  
- State-driven UI  
- Reusable, composable components  



## 🚀 Quick Setup

1. **Firebase**  
   Create a Firebase project, enable Email/Password authentication, and turn on Firestore.

2. **GoogleService-Info.plist**  
   Download your `GoogleService-Info.plist` and drag it into the root of the Xcode project.

3. **Firestore Rules**  
   Ensure users can only read and write their own document:
   ```javascript
   allow read, write: if request.auth != nil && request.auth.uid == userId;
   ```


## ⚙️ Making It Yours

This is a **starting point**, not a finished product. The goal is flexibility.

### ➕ Adding Data

Want to save additional user data like a birthday, username, or bio?

- Add the field to the `User.swift` model  
- Add an another forumField input to the registration view  
- Firestore will stay in sync automatically  

The structure is intentionally simple so extending it doesn’t feel painful.

### 🎨 Styling

All UI is built with **pure SwiftUI** and system components.

- Swap system colors or fonts in shared components  
- Add your own color assets for branding  
- Customize layouts without fighting the architecture  


## 🗺 What’s Next?

This template evolves as I reuse it in my own projects. Planned features include:

- [ ] Forgot Password – Basic email reset flow  
- [ ] Social Auth – Sign in with Apple and Google  
- [ ] Profile Pictures – Firebase Storage integration for avatars  
- [ ] Email Verification – Ensure users use real, verified emails  


## 📄 Use It

This project is **open-source**.

Use it for personal apps, side projects, school assignments, or as the foundation for something much bigger.

If this template saves you even an hour of setup time, that’s a win.
