// Display row used in settings-style lists for navigation or actions.
// Component layer to standardize icon + label presentation across sections.

import SwiftUI

/// A row with an icon and label used in lists of settings or account actions.
struct SettingsRow: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
             
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            
            
        }
    }
}

#Preview {
    SettingsRow(imageName: "gear", title: "title", tintColor: Color(.systemGray))
}
