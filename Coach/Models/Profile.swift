//
//  Profile.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/17/22.
//

import Foundation

struct Profile: Identifiable {
    let id: UUID
    var name: String
    var sessions: [Session]
    
    init(id: UUID = UUID(), name: String, sessions: [Session]) {
        self.id = id
        self.name = name
        self.sessions = sessions
    }
}

extension Profile {
    struct Data {
        var name: String = ""
    }
    
    var data: Data {
        Data(name: name)
    }
    
    mutating func update(from data: Data) {
        name = data.name
    }
    
    init(data: Data) {
        id = UUID()
        name = data.name
        sessions = []
    }
}

extension Profile {
    static let sampleData: [Profile] =
    [
        Profile(name: "Sample Profile",
                sessions:
                    [
                        Session(name: "Timed",
                                theme: .oxblood,
                                activities:
                                    [
                                        Session.Activity(name: "Activity 1", lengthInSeconds: 30),
                                        Session.Activity(name: "Activity 2", lengthInSeconds: 30),
                                        Session.Activity(name: "Activity 3", lengthInSeconds: 30)
                                    ]),
                        Session(name: "UnTimed",
                                theme: .oxblood,
                                activities:
                                    [
                                        Session.Activity(name: "Activity 1", lengthInSeconds: 0),
                                        Session.Activity(name: "Activity 2", lengthInSeconds: 0),
                                        Session.Activity(name: "Activity 3", lengthInSeconds: 0)
                                    ])
                    ])
    ]
}
