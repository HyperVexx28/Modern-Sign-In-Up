// Registration screen capturing user credentials and creating Firebase accounts via AuthViewModel.
// MVVM "View" layer responsible for user input and basic validation before hitting backend services.

import SwiftUI

/// Presents the sign-up form, validates inputs, and triggers account creation.
struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPass = ""
    @Environment(\.dismiss) var dismiss
    // Shared auth view model handles Firebase writes and session updates.
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        VStack{
            Image("Placeholder")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            //forum fields
            VStack(spacing:24){
                ForumField(text: $email,
                          title: "Email Address",
                          placeholder: "name@example.com")
                .autocapitalization(.none)
                
                ForumField(text: $fullName,
                          title: "Full Name",
                          placeholder: "Enter your full name")
                
                ForumField(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                
                ZStack(alignment:.trailing){
                    ForumField(text: $confirmPass, title: "Confirm Password", placeholder: "Re-enter your password", isSecureField: true)
                    
                    if !password.isEmpty && !confirmPass.isEmpty{
                        if password == confirmPass{
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
                    
                    
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            //Sign up button
            
            Button {
                Task{
                    // Async boundary to create a user and store profile data.
                    try await viewModel.createUser(withEmail: email, password: password, fullName: fullName)
                }
            } label: {
                HStack{
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32,height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0: 0.5)
            .cornerRadius(10)
            .padding(.top, 24)
            
            
            Spacer() 
            
            //Back to login button
            Button {
                dismiss()
            } label: {
                HStack(spacing:3 ){
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                        .font(.system(size: 14))
                }
            }
        }
    }
}
// Form validation contract for registration inputs.
extension RegistrationView : AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && !fullName.isEmpty
        && confirmPass == password
    }
}
#Preview {
    RegistrationView()
}
