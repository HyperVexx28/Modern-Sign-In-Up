//
//  Modern_Sign_In_UpApp.swift
//  Modern-Sign-In-Up
//
//  Created by Mohamad Shehab on 12/12/2025.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct Modern_Sign_In_UpApp: App {
    //Initialising 1 instance of authViewModel to use across the app
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
