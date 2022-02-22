//
//  CoachApp.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/17/22.
//

import SwiftUI

@main
struct CoachApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            NavigationView {
                ProfilesView(profiles: .constant(Profile.sampleData))
            }
        }
    }
}
