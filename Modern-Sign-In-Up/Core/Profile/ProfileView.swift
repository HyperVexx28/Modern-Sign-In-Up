//
//  ProfileView.swift
//  Modern-Sign-In-Up
//
//  Created by Mohamad Shehab on 15/12/2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser{
            List{
                Section{
                    HStack{
                        //Profile image or initals for now
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray2))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4){
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
                
                Section("General"){
                    
                    HStack{
                        SettingsRow(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        
                        Spacer()
                         
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Account"){
                    
                    Button{
                        viewModel.signOut()
                    } label: {
                        SettingsRow(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                    }
                    
                    Button{
                        print("Delete user out")
                    } label: {
                        SettingsRow(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
