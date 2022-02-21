//
//  ProfilesView.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/20/22.
//

import SwiftUI

struct ProfilesView: View {
    var profiles: [Profile]
    
    var body: some View {
        List {
            ForEach(profiles) { profile in
                NavigationLink(destination: SessionsView(profileName: profile.name, sessions: profile.sessions)) {
                    Text(profile.name)
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                        .padding()
                }
            }
        }
        .navigationTitle("Profiles")
    }
}

struct ProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilesView(profiles: Profile.sampleData)
    }
}
