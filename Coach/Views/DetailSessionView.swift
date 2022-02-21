//
//  DetailSessionView.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/21/22.
//

import SwiftUI

struct DetailSessionView: View {
    var session: Session
    
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
    }
}

struct DetailSessionView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSessionView(session: Profile.sampleData[0].sessions[0])
        DetailSessionView(session: Profile.sampleData[0].sessions[1])
    }
}
