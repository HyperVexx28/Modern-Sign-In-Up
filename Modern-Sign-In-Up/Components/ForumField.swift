//
//  InputView.swift
//  Modern-Sign-In-Up
//
//  Created by Mohamad Shehab on 14/12/2025.
//

import SwiftUI

struct ForumField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    //
    //jh
    var body: some View {
        VStack(alignment:.leading, spacing: 12){
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                
            } else{
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            
            Divider()
        }
    }
}

#Preview {
    ForumField(text: .constant("") , title: "Email Adress", placeholder: "name@example.com")
}
