//
//  SessionFooterView.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/17/22.
//

import SwiftUI

struct SessionFooterView: View {
    let activityIndex: Int
    let totalActivities: Int
    let rewindAction: ()->Void
    let forwardAction: ()->Void
    
    private var intervalNumber: Int {
        guard totalActivities > 0 else { return 0 }
        guard activityIndex >= 0 else { return 1 }
        guard activityIndex < totalActivities else { return totalActivities }
        return activityIndex + 1
    }
    private var intervalText: String {
        guard totalActivities > 0 else {
            return "No activities available!"
        }
        return "\(intervalNumber) of \(totalActivities)"
    }
    private var isFirstInterval: Bool {
        return activityIndex <= 0
    }
    private var isLastInterval: Bool {
        return activityIndex + 1 >= totalActivities
    }
    
    var body: some View {
        VStack {
            HStack {
                if isFirstInterval {
                    Button(action: {}) {
                        Image(systemName: "backward")
                    }
                } else {
                    Button(action: rewindAction) {
                        Image(systemName: "backward.fill")
                    }
                }
                Spacer()
                Text(intervalText)
                Spacer()
                if isLastInterval {
                    Button(action: {}) {
                        Image(systemName: "forward")
                    }
                } else {
                    Button(action: forwardAction) {
                        Image(systemName: "forward.fill")
                    }
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(intervalText)
        .padding([.bottom, .horizontal])
    }
}

struct SessionFooterView_Previews: PreviewProvider {
    static var previews: some View {
        SessionFooterView(activityIndex: 0, totalActivities: 17, rewindAction: {}, forwardAction: {})
            .previewLayout(.sizeThatFits)
    }
}
