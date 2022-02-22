//
//  SessionEditView.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/21/22.
//

import SwiftUI

struct SessionEditView: View {
    @Binding var data: Session.Data
    @State private var newActivityName = ""
    @State private var newActivitySeconds = ""
    
    var body: some View {
        Form {
            Section(header: Text("Session Info")) {
                TextField("Name", text: $data.name)
                ThemePickerView(selection: $data.theme)
            }
            Section(header: Text("Activities")) {
                ForEach(data.activities) {activity in
                    HStack {
                        Text(activity.name)
                        Spacer()
                        if activity.lengthInSeconds > 0 {
                            Text(ActivityTimer.seconds2Text(time: activity.lengthInSeconds))
                        }
                    }
                }
                .onDelete {indices in
                    data.activities.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Activity", text: $newActivityName)
                    TextField("Seconds", text: $newActivitySeconds)
                        .keyboardType(.decimalPad)
                    Button(action: {
                        withAnimation {
                            let lengthInSeconds = Int(newActivitySeconds) ?? 0
                            let activity = Session.Activity(name: newActivityName, lengthInSeconds: lengthInSeconds)
                            data.activities.append(activity)
                            newActivityName = ""
                            newActivitySeconds = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add activity")
                    }
                    .disabled(newActivityName.isEmpty)
                }
            }
        }
    }
}

struct SessionEditView_Previews: PreviewProvider {
    static var previews: some View {
        SessionEditView(data: .constant(Profile.sampleData[0].sessions[0].data))
    }
}
