// Application entry point wiring Firebase and environment dependencies for MVVM views.
// Hosts the shared auth view model and sets up the initial SwiftUI scene for the app shell.

import SwiftUI
import SwiftData
import Firebase

/// Root application that configures Firebase and injects the authentication view model.
@main
struct Modern_Sign_In_UpApp: App {
    // Single shared auth view model to keep session state consistent across views.
    @StateObject var viewModel = AuthViewModel()
    
    /// Configures Firebase before any view renders.
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Provide the auth state to the entire hierarchy.
                .environmentObject(viewModel)
        }
    }
}
