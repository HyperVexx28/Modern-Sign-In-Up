// Authentication view model owning Firebase session state and coordinating account lifecycle operations.
// Lives in the MVVM "ViewModel" layer and exposes async methods consumed by SwiftUI views.

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

/// Shared interface for validating authentication form inputs.
protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

/// Manages authentication session, user profile retrieval, and account lifecycle against Firebase services.
/// - Responsibilities: sign-in/up, profile fetch, sign-out, and account deletion with Firestore cleanup.
/// - Inputs: email/password credentials, user details for registration, password confirmation for deletion.
/// - Outputs: published `userSession`, `currentUser`, and loading state consumed by SwiftUI views.
/// - Side effects: Firebase Auth calls, Firestore reads/writes, and in-memory state changes.
/// - Concurrency: main-actor isolated; async Firebase operations hop to background threads internally.
@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var loadingMessage = ""
    
    init() {
        self.userSession = Auth.auth().currentUser
        // Prefetch the user profile on launch if a session already exists.
        Task { await fetchUser() }
    }
    
    /// Signs in an existing user and refreshes their profile from Firestore.
    /// Throws Firebase-authentication errors for invalid credentials or network failures.
    func signIn(withEmail email: String, password: String) async throws {
        loadingMessage = "Signing you in..."
        isLoading = true
        defer { isLoading = false }
        
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = result.user
        await fetchUser()
    }
    
    /// Creates a new account, persists the profile to Firestore, and hydrates local state.
    /// Side effects include Auth user creation and a Firestore document write for the user record.
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        loadingMessage = "Creating your Account!"
        isLoading = true
        defer { isLoading = false }
        
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        self.userSession = result.user
        
        let user = User(id: result.user.uid, fullName: fullName, email: email)
        let encodedUser = try Firestore.Encoder().encode(user)
        try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        await fetchUser()
    }
    
    /// Deletes the current account after re-authenticating, removing Firestore profile data and Auth identity.
    /// Requires the user's password; throws if re-authentication or deletion fails.
    func deleteAccount(password: String) async throws {
        loadingMessage = "Deleting..."
        isLoading = true
        defer { isLoading = false }
        
        guard let user = Auth.auth().currentUser else { return }
        let email = user.email ?? ""
        
        // Firebase requires a recent login; re-authenticate before destructive operations.
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        try await user.reauthenticate(with: credential)
        
        // Remove the profile document before deleting the Auth user to avoid orphaned data.
        try await Firestore.firestore().collection("users").document(user.uid).delete()
        
        // Delete the Auth identity to finalize account removal.
        try await user.delete()
        
        // Clear local state so UI returns to an unauthenticated flow.
        self.userSession = nil
        self.currentUser = nil
    }
    
    /// Signs out locally and clears cached user data.
    /// Prints a debug message on failure; UI remains unchanged if sign-out fails.
    func signOut() {
        loadingMessage = "Signing out"
        isLoading = true
        defer { isLoading = false }
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            // TODO: Surface sign-out failures to the UI instead of printing.
            print("DEBUG: Failed to sign out")
        }
    }
    
    /// Fetches the user's profile document from Firestore and updates published state.
    /// Returns early when no authenticated user is present.
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
