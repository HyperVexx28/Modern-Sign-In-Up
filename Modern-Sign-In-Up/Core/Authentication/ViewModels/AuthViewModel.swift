//
//  AuthViewModel.swift
//  Modern-Sign-In-Up
//
//  Created by Mohamad Shehab on 17/12/2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool {get}
}

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isLoading = false // Global loading state
    @Published var loadingMessage = ""
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task { await fetchUser() }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        loadingMessage = "Signing you in..."
        isLoading = true
        defer { isLoading = false }
        
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = result.user
        await fetchUser()
    }
    
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
    
    func deleteAccount(password: String) async throws {
        loadingMessage = "Deleting..."
        isLoading = true
        defer { isLoading = false }
        
        guard let user = Auth.auth().currentUser else { return }
        let email = user.email ?? ""
        
        // Re-authenticate
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        try await user.reauthenticate(with: credential)
        
        // Delete Firestore Data
        try await Firestore.firestore().collection("users").document(user.uid).delete()
        
        // Delete Auth Account
        try await user.delete()
        
        // Clear local state
        self.userSession = nil
        self.currentUser = nil
    }
    
    func signOut() {
        loadingMessage = "Signing out"
        isLoading = true
        defer{isLoading = false}
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
