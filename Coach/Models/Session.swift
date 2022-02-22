//
//  Session.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/18/22.
//

import Foundation


struct Session: Identifiable, Codable {
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
    struct Activity: Identifiable, Codable {
        let id: UUID
        var name: String
        var lengthInSeconds: Int
        
        init(id: UUID = UUID(), name: String, lengthInSeconds: Int) {
            self.id = id
            self.name = name
            self.lengthInSeconds = lengthInSeconds
        }
    }
    
    struct Data {
        var name: String = ""
        var activities: [Activity] = []
        var theme: Theme = .seafoam
    }
    
    var data: Data {
        Data(name: name, activities: activities, theme: theme)
    }
    
    mutating func update(from data: Data) {
        name = data.name
        activities = data.activities
        theme = data.theme
    }
    
    init(data: Data) {
        id = UUID()
        name = data.name
        activities = data.activities
        theme = data.theme
    }
}
