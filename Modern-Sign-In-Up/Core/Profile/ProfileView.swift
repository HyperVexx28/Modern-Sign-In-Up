// Authenticated profile surface showing account metadata and account management actions.
// SwiftUI view in the MVVM "View" layer consuming AuthViewModel for state and side effects.
import SwiftUI

/// Displays the signed-in user's information and exposes sign-out and account deletion actions.
struct ProfileView: View {
    // Shared auth state drives displayed user info and actions.
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var showDeleteAlert = false
    @State private var showErrorAlert = false
    @State private var password = ""
    @State private var errorMessage = ""

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
                            Text("1.0.0").foregroundColor(.gray)
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
                    }
                }
                // Block interactions while auth operations are in-flight to avoid duplicate requests.
                .disabled(viewModel.isLoading)
                .alert("Delete Account", isPresented: $showDeleteAlert) {
                    SecureField("Enter password to confirm", text: $password)
                    Button("Delete", role: .destructive) {
                        // Async boundary to re-authenticate and delete the account from Firebase/Firestore.
                        Task {
                            do {
                                try await viewModel.deleteAccount(password: password)
                            } catch {
                                self.errorMessage = error.localizedDescription
                                self.showErrorAlert = true
                            }
                            password = ""
                        }
                    }
                    Button("Cancel", role: .cancel) { password = "" }
                } message: {
                    Text("This is permanent. Enter your password to delete your data.")
                }
                .alert("Error", isPresented: $showErrorAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(errorMessage)
                }
            }

            // Present a loading overlay when backend work is occurring to keep UX responsive.
            if viewModel.isLoading {
                LoadingView(message: viewModel.loadingMessage)
            }
        }
    }
}
