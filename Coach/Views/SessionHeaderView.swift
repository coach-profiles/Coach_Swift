//
//  SessionHeaderView.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/17/22.
//

import SwiftUI

struct SessionHeaderView: View {
    let name: String
    let activityIndex: Int
    let totalActivities: Int
    var secondsElapsed: Int = 0
    var totalSeconds: Int = 0
    let theme: Theme
    
    private var secondsRemaining: Int {
        totalSeconds - secondsElapsed
    }
    private var progress: Double {
        guard activityIndex >= 0 else { return 0}
        guard totalActivities > 0, activityIndex < totalActivities else { return 1 }
        guard totalSeconds > 0 else { return Double(activityIndex) / Double(totalActivities) }
        return min(1.0, Double(activityIndex) * Double(totalSeconds + secondsElapsed) / (Double(totalActivities) * Double(totalSeconds)))
    }
    
    private var timeElapsed: String {
        ActivityTimer.seconds2Text(time: secondsElapsed)
    }
    
    private var timeRemaining: String {
        ActivityTimer.seconds2Text(time: secondsRemaining)
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(SessionProgressViewStyle(theme: theme))
                .accessibilityValue(name)
            HStack {
                if totalSeconds > 0 {
                    VStack(alignment: .leading) {
                        Text("Time Elapsed")
                            .font(.caption)
                        Label(timeElapsed, systemImage: "hourglass.bottomhalf.fill")
                    }
                }
                Spacer()
                Text(name)
                Spacer()
                if totalSeconds > 0 {
                    VStack(alignment: .trailing) {
                        Text("Time Remaining")
                            .font(.caption)
                        Label(timeRemaining, systemImage: "hourglass.tophalf.fill")
                            .labelStyle(.trailingIcon)
                    }
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityValue("\(secondsRemaining)")
        }
        .padding([.top, .horizontal])
    }
}

struct SessionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SessionHeaderView(name: "Untimed", activityIndex: 1, totalActivities: 3, theme: .bubblegum)
            SessionHeaderView(name: "Timed", activityIndex: 0, totalActivities: 4, secondsElapsed: 60, totalSeconds: 240, theme: .bubblegum)
        }
        .previewLayout(.sizeThatFits)
    }
}
