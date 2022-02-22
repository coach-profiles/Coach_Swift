//
//  CoachApp.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/17/22.
//

import SwiftUI

@main
struct CoachApp: App {
    @StateObject private var store = ProfileStore()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            NavigationView {
                ProfilesView(profiles: $store.profiles) {
                    Task {
                        do {
                            try await ProfileStore.save(profiles: store.profiles)
                        } catch {
                            fatalError("Error saving profiles.")
                        }
                    }
                }
            }
            .task {
                do {
                    store.profiles = try await ProfileStore.load()
                } catch {
                    fatalError("Error loading profiles.")
                }
            }
        }
    }
}
