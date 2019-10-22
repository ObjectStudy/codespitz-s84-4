//
//  Task.swift
//  84-4
//
//  Created by tskim on 21/10/2019.
//  Copyright © 2019 assin. All rights reserved.
//

import Foundation

class Task {
    var title: String
    var date: Date
    var isComplete: Bool


    public init(title: String, date: Date, isComplete: Bool = false) {
        self.title = title
        self.date = date
        self.isComplete = isComplete
    }
    
    public func toggle() {
        isComplete = !isComplete
    }
}
