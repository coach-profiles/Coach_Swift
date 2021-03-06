//
//  ActivityTimer.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/18/22.
//

import Foundation

class ActivityTimer: ObservableObject {
    struct Interval: Identifiable {
        let id: UUID = UUID()
        let name: String
        var totalSeconds: Int
    }
    
    private(set) var intervals: [Interval]
    /// A closure that is executed when an interval (or activity) is about to be changed.
    var intervalChangeWarningAction: ((String) -> Void)?
    /// A closure that is executed when an interval (or activity) is changed.
    var intervalChangedAction: ((String) -> Void)?
    
    @Published var intervalName: String = ""
    @Published var intervalIndex: Int = -1
    @Published var secondsElapsed: Int = 0
    @Published var lengthInSeconds: Int = 0
    
    private var timer: Timer?
    private var frequency: TimeInterval { 1.0 }
    private var startDate: Date?
    
    /**
     Initialize a new timer.
     Use `startSession()` to start the timer.
     
     - Parameters:
        - activities: A list of activities in the session.
     */
    init(activities: [Session.Activity] = []) {
        intervals = activities.intervals
    }
    
    /**
     Reset the timer with new activities.
     - Parameters:
        - activities: A list of activities in the new session.
     */
    func reset(activities: [Session.Activity]) {
        self.intervals = activities.intervals
    }
    
    /**
     Starts session timer.
     */
    func startSession() {
        changeToInterval(at: 0)
    }
    
    /**
     Stops session timer.
     */
    func stopSession() {
        /// Stop any timed interval.
        changeToInterval(at: intervals.count)
    }
    
    /**
     Rewind the timer to the previous activity (or interval).
     */
    func previousActivity() {
        changeToInterval(at: intervalIndex - 1)
    }
    
    /**
     Advance the timer to the next activity (or interval).
     */
    func nextActivity() {
        changeToInterval(at: intervalIndex + 1)
    }
    
    private func changeToInterval(at index: Int) {
        /// Stop timer
        timer?.invalidate()
        timer = nil
        startDate = nil
        
        /// Initialize timer-dependent and published variables.
        secondsElapsed = 0
        intervalIndex = index
        if 0 <= index && index < intervals.count {
            intervalName = intervals[intervalIndex].name
            lengthInSeconds = intervals[intervalIndex].totalSeconds
        } else {
            intervalName = ""
            lengthInSeconds = 0
        }
        
        /// Call optional interval changed action
        let announcement = intervalName
        intervalChangedAction?(announcement)
        
        guard intervalIndex >= 0, intervalIndex < intervals.count, intervals[intervalIndex].totalSeconds > 0 else { return }
        
        /// Initialize the timer variables.
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            if let self = self, let startDate = self.startDate {
                let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
                self.update(secondsElapsed: Int(secondsElapsed))
            }
        }
    }
    
    private func update(secondsElapsed: Int) {
        self.secondsElapsed = secondsElapsed
        
        let secondsRemaining = lengthInSeconds - secondsElapsed
        if (0 < secondsRemaining && secondsRemaining < 4) {
            let announcement = String(secondsRemaining)
            intervalChangeWarningAction?(announcement)
        }
        
        /// Change to next interval is timer is complete
        guard secondsElapsed >= lengthInSeconds else { return }
        changeToInterval(at: intervalIndex + 1)
    }
}

extension Session {
    var timer: ActivityTimer {
        ActivityTimer(activities: activities)
    }
}

extension Array where Element == Session.Activity {
    var intervals: [ActivityTimer.Interval] {
        if isEmpty {
            return []
        } else {
            return map { ActivityTimer.Interval(name: $0.name, totalSeconds: $0.lengthInSeconds) }
        }
    }
}

extension ActivityTimer {
    static func seconds2Text(time: Int) -> String {
        var seconds = time
        let minutes = seconds / 60
        seconds = seconds % 60
        
        return String("\(minutes.withPadding()):\(seconds.withPadding())")
    }
}

extension Int {
    func withPadding() -> String {
        return String(format: "%02d", self)
    }
}
