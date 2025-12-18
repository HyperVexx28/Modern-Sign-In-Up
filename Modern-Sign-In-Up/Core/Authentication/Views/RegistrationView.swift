//
//  RegistrationView.swift
//  Modern-Sign-In-Up
//
//  Created by Mohamad Shehab on 14/12/2025.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPass = ""
    @Environment(\.dismiss) var dismiss
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
                
                ForumField(text: $email,
                          title: "Full Name",
                          placeholder: "Enter your full name")
                
                ForumField(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                
                ForumField(text: $password, title: "Confirm Password", placeholder: "Re-enter your password", isSecureField: true)
                    
                    
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            //Sign up button
            
            Button {
                Task{
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

#Preview {
    RegistrationView()
}
