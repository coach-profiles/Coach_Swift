//
//  ProfileView.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/20/22.
//

import SwiftUI

struct ProfileView: View {
    @Binding var profile: Profile
    @State private var isPresentingNewSessionView = false
    @State private var newSessionData = Session.Data()
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($profile.sessions) { $session in
                NavigationLink(destination: SessionDetailView(session: $session, saveAction: saveAction)) {
                    Text(session.name)
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                        .padding()
                }
            }
        }
        .navigationTitle(profile.name)
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
                                profile.sessions.append(newSession)
                                saveAction()
                                isPresentingNewSessionView = false
                                newSessionData = Session.Data()
                            }
                        }
                    }
            }
        }
    }
}

struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: .constant(Profile.sampleData[0]), saveAction: {})
    }
}
