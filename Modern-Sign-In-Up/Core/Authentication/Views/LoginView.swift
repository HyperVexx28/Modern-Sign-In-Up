//
//  LoginView.swift
//  Modern-Sign-In-Up
//
//  Created by Mohamad Shehab on 13/12/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
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
                .disabled(formIsValid)
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
//form validation
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count >= 6
    }
    
    
}
#Preview {
    LoginView()
}
