//
//  Session.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/18/22.
//

import Foundation


struct Session: Identifiable {
    let id: UUID
    var name: String
    var theme: Theme
    var activities: [Activity]
    
    init(id: UUID = UUID(), name: String, theme: Theme, activities: [Activity]) {
        self.id = id
        self.name = name
        self.theme = theme
        self.activities = activities
    }
}

extension Session {
    struct Activity: Identifiable {
        let id: UUID
        var name: String
        var lengthInSeconds: Int
        
        init(id: UUID = UUID(), name: String, lengthInSeconds: Int) {
            self.id = id
            self.name = name
            self.lengthInSeconds = lengthInSeconds
        }
    }
}
