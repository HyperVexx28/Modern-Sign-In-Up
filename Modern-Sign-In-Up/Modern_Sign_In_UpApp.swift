//
//  Modern_Sign_In_UpApp.swift
//  Modern-Sign-In-Up
//
//  Created by Mohamad Shehab on 12/12/2025.
//

import SwiftUI
import SwiftData

@main
struct Modern_Sign_In_UpApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
