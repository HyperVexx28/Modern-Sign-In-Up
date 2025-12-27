// Sign-in screen for existing users, validating credentials and triggering AuthViewModel login.
// MVVM "View" layer that binds form state to authentication logic via environment object.

import SwiftUI

/// Presents the sign-in form and routes to registration when needed.
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    // Consumes shared auth view model to initiate sign-in and observe loading state if needed.
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                //image
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
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    ForumField(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //sign in button
                
                Button {
                    Task {
                       // Async boundary to execute Firebase-backed sign-in.
                       try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack{
                        Text("SIGN IN")
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
                
                //sign up button
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing:3 ){
                        Text("Dont have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                    }
                }

                
            }
        }
    }
}
// Form validation contract for login inputs.
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
    
    
}
#Preview {
    LoginView()
}
