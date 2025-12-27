// Full-screen loading overlay that blocks interactions while work is in progress.
// Shared component to provide consistent progress feedback across flows.

import SwiftUI

import SwiftUI


/// Presents a modal-style loading indicator with a custom message.
struct LoadingView: View {
    let message: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.25)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                ProgressView()
                    .controlSize(.large)
                    .tint(.blue)
                
                Text(message)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .padding(25)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 10)
        }
    }
}
#Preview {
    LoadingView(message: "")
}
