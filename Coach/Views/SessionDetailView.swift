//
//  SessionDetailView.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/21/22.
//

import SwiftUI

struct SessionDetailView: View {
    @Binding var session: Session
    
    @State private var data = Session.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("Session Info")) {
                NavigationLink(destination: SessionView(session: session)) {
                    Label("Start Session", systemImage: "play.fill")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(session.theme.name)
                        .padding(4)
                        .foregroundColor(session.theme.accentColor)
                        .background(session.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Activities")) {
                ForEach(session.activities) { activity in
                    HStack {
                        Label(activity.name, systemImage: "timer")
                        Spacer()
                        if activity.lengthInSeconds > 0 {
                            Text(ActivityTimer.seconds2Text(time: activity.lengthInSeconds))
                        }
                    }
                    .accessibilityLabel("\(activity.name) \(activity.lengthInSeconds) seconds")
                }
            }
        }
        .navigationTitle(session.name)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = session.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                SessionEditView(data: $data)
                    .navigationTitle(session.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                session.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailView(session: .constant(Profile.sampleData[0].sessions[0]))
        SessionDetailView(session: .constant(Profile.sampleData[0].sessions[1]))
    }
}
