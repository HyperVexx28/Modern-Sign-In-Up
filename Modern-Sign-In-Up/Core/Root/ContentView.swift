//
//  ContentView.swift
//  Modern-Sign-In-Up
//
//  Created by Mohamad Shehab on 12/12/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group{
            if viewModel.userSession != nil{
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
        
    }

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
