// Root switcher deciding between authenticated profile experience and login/register flow.
// Acts as the MVVM view layer entry that reacts to auth state published by AuthViewModel.

import SwiftUI
import SwiftData

/// Entry view that routes between login/registration and profile based on session state.
struct ContentView: View {
    // Access the shared auth state for conditional rendering.
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group{
            // Authenticated sessions land on the profile; otherwise present login.
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
