//
//  SessionsView.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/20/22.
//

import SwiftUI

struct SessionsView: View {
    var profileName: String
    @Binding var sessions: [Session]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewSessionView = false
    @State private var newSessionData = Session.Data()
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($sessions) { $session in
                NavigationLink(destination: SessionDetailView(session: $session)) {
                    Text(session.name)
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                        .padding()
                }
            }
        }
        .navigationTitle(profileName)
        .toolbar {
            Button(action: {
                isPresentingNewSessionView = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewSessionView) {
            NavigationView {
                SessionEditView(data: $newSessionData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewSessionView = false
                                newSessionData = Session.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newSession = Session(data: newSessionData)
                                sessions.append(newSession)
                                isPresentingNewSessionView = false
                                newSessionData = Session.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) {phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        SessionsView(profileName: Profile.sampleData[0].name, sessions: .constant(Profile.sampleData[0].sessions), saveAction: {})
    }
}
