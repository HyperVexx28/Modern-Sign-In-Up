//
//  LoadingView.swift
//  Modern-Sign-In-Up
//
//  Created by Mohamad Shehab on 25/12/2025.
//

import SwiftUI

import SwiftUI


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
