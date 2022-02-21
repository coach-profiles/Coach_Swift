//
//  SessionsView.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/20/22.
//

import SwiftUI

struct SessionsView: View {
    var profileName: String
    var sessions: [Session]
    
    var body: some View {
        List {
            ForEach(sessions) { session in
                NavigationLink(destination: DetailSessionView(session: session)) {
                    Text(session.name)
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                        .padding()
                }
            }
        }
        .navigationTitle(profileName)
    }
}

struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        SessionsView(profileName: Profile.sampleData[0].name, sessions: Profile.sampleData[0].sessions)
    }
}
