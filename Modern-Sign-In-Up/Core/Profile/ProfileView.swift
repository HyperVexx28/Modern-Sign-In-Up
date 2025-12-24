import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    // UI State
    @State private var showDeleteAlert = false
    @State private var showErrorAlert = false
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isDeleting = false // New: Loading state tracker

    var body: some View {
        ZStack {
            if let user = viewModel.currentUser {
                List {
                    Section {
                        HStack {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray2))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.fullName)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                    .font(.subheadline)
                                
                                Text(user.email)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Section("General") {
                        HStack {
                            SettingsRow(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                            Spacer()
                            Text("1.0.0")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Section("Account") {
                        Button {
                            viewModel.signOut()
                        } label: {
                            SettingsRow(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                        }
                        
                        Button {
                            showDeleteAlert = true
                        } label: {
                            SettingsRow(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                        }
                        .disabled(isDeleting) // Prevent clicks while deleting
                    }
                }
                .alert("Delete Account", isPresented: $showDeleteAlert) {
                    SecureField("Enter password to confirm", text: $password)
                    
                    Button("Delete", role: .destructive) {
                        Task {
                            await handleDeleteAccount()
                        }
                    }
                    Button("Cancel", role: .cancel) { password = "" }
                } message: {
                    Text("This action is irreversible. Please enter your password to confirm.")
                }
                .alert("Action Failed", isPresented: $showErrorAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
            }

            // MARK: - Loading Overlay
            if isDeleting {
                ZStack {
                    Color.black.opacity(0.25)
                        .ignoresSafeArea()
                    
                    ProgressView("Deleting Account...")
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
        }
    }
    
    // Helper function to handle the logic
    private func handleDeleteAccount() async {
        isDeleting = true
        do {
            try await viewModel.deleteAccount(password: password)
            // If successful, the viewModel updates currentUser to nil
            // and the UI will naturally transition away.
        } catch {
            self.errorMessage = error.localizedDescription
            self.showErrorAlert = true
        }
        isDeleting = false
        password = ""
    }
}
