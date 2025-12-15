//
//  ProfileView.swift
//  Modern-Sign-In-Up
//
//  Created by Mohamad Shehab on 15/12/2025.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        List{
            Section{
                HStack{
                    //Profile image or initals for now
                    Text("MJ")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray2))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text("Michael Jordan")
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                            .font(.subheadline)
                        
                        Text("test@gmail.com")
                            .font(.footnote)
                            .accentColor(.gray)
                        
                    }
                }
                
            }
            
            Section("General"){
                
            }
            
            Section("Account"){
                
            }
        }
    }
}

#Preview {
    ProfileView()
}
