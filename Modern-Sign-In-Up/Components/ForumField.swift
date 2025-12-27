// Reusable text/secure input field with label styling for auth-related forms.
// Lives in the shared UI components layer to keep views concise and consistent.

import SwiftUI

/// Labeled text field supporting secure entry for authentication forms.
struct ForumField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    // Toggle to render secure entry when true.
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
