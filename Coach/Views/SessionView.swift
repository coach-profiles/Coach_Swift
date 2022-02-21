//
//  SessionView.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/17/22.
//

import SwiftUI
import AVFoundation

struct SessionView: View {
    var session: Session
    @StateObject var activityTimer = ActivityTimer()
    
    private let synthesizer: ActivitySpeechSynthesizer = ActivitySpeechSynthesizer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(session.theme.mainColor)
            VStack {
                SessionHeaderView(name: activityTimer.intervalName, activityIndex: activityTimer.intervalIndex, totalActivities: activityTimer.intervals.count, secondsElapsed: activityTimer.secondsElapsed, totalSeconds: activityTimer.lengthInSeconds, theme: session.theme)
                Circle()
                SessionFooterView(activityIndex: activityTimer.intervalIndex, totalActivities: activityTimer.intervals.count, rewindAction: activityTimer.previousActivity, forwardAction: activityTimer.nextActivity)
            }
        }
        .padding()
        .foregroundColor(session.theme.accentColor)
        .onAppear {
            activityTimer.reset(activities: session.activities)
            activityTimer.intervalChangeWarningAction = { secondsRemaining in
                synthesizer.notify(notification: secondsRemaining)
            }
            activityTimer.intervalChangedAction = { activityName in
                synthesizer.notify(notification: activityName)
            }
            activityTimer.startSession()
        }
        .onDisappear {
            activityTimer.stopSession()
        }
        .navigationTitle(session.name)
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(session: Profile.sampleData[0].sessions[0])
        SessionView(session: Profile.sampleData[0].sessions[1])
    }
}
