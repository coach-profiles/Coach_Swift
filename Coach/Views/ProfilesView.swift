//
//  ProfilesView.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/20/22.
//

import SwiftUI

struct ProfilesView: View {
    @Binding var profiles: [Profile]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewProfileView = false
    @State private var newProfileData = Profile.Data()
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($profiles) { $profile in
                NavigationLink(destination: ProfileView(profile: $profile, saveAction: saveAction)) {
                    Text(profile.name)
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                        .padding()
                }
            }
        }
        .navigationTitle("Profiles")
        .toolbar {
            Button(action: {
                isPresentingNewProfileView = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewProfileView) {
            NavigationView {
                ProfileEditView(data: $newProfileData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewProfileView = false
                                newProfileData = Profile.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newProfile = Profile(data: newProfileData)
                                profiles.append(newProfile)
                                isPresentingNewProfileView = false
                                newProfileData = Profile.Data()
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

struct ProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilesView(profiles: .constant(Profile.sampleData), saveAction: {})
    }
}
