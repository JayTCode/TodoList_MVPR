//
//  TodoList.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-16.
//

import Foundation

struct Task: Hashable, Equatable {
    let id = UUID()
    let title: String
    let dueDate: Date
    let priority: String
    let category: Category
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Task {
    static func sampleData() -> [Task] {
        return [
            Task(title: "Submit taxes to CRA", dueDate: Date(timeInterval: 24500, since: Date.now), priority: "1", category: .personal),
            Task(title: "Buy a new house", dueDate: Date(timeInterval: 692000, since: Date.now), priority: "3", category: .personal),
            Task(title: "Go for a workout", dueDate: Date(timeInterval: 45000, since: Date.now), priority: "5", category: .personal),
            
            Task(title: "Submit Financial Report to CFO", dueDate: Date(timeInterval: 54000, since: Date.now), priority: "3", category: .work),
            Task(title: "Debug code", dueDate: Date(timeInterval: 1000, since: Date.now), priority: "5", category: .work),
            Task(title: "Complete adminstrative tasks", dueDate: Date(timeInterval: 224000, since: Date.now), priority: "1", category: .work),
            
            Task(title: "Create grocery list", dueDate: Date(timeInterval: 11600, since: Date.now), priority: "5", category: .errands),
            Task(title: "Walk the dog", dueDate: Date(timeInterval: 110000, since: Date.now), priority: "3", category: .errands),
            Task(title: "Hunt a bear", dueDate: Date(timeInterval: 54000, since: Date.now), priority: "1", category: .errands),
            
            Task(title: "Adopt a lion as a pet", dueDate: Date(timeInterval: 120000, since: Date.now), priority: "2", category: .fun),
            Task(title: "Wrestle a bear", dueDate: Date(timeInterval: 500000, since: Date.now), priority: "4", category: .fun),
            Task(title: "Wrestle a lion", dueDate: Date(timeInterval: 260000, since: Date.now), priority: "5", category: .fun),
            
            Task(title: "Calculate how much it would cost to put down on mortgage in current economy", dueDate: Date(timeInterval: 20000, since: Date.now), priority: "2", category: .family),
            Task(title: "Go on a vacation with the family", dueDate: Date(timeInterval: 152000, since: Date.now), priority: "4", category: .family),
            Task(title: "Buy mom a house", dueDate: Date(timeInterval: 260000, since: Date.now), priority: "1", category: .family),
            
            Task(title: "Buy new shoes", dueDate: Date(timeInterval: 82000, since: Date.now), priority: "1", category: .shopping),
            Task(title: "Buy a new truck", dueDate: Date(timeInterval: 184500, since: Date.now), priority: "4", category: .shopping),
            Task(title: "Buy new clothes", dueDate: Date(timeInterval: 15000, since: Date.now), priority: "2", category: .shopping),
            
            Task(title: "Go vote", dueDate: Date(timeInterval: 120000, since: Date.now), priority: "3", category: .misc),
            Task(title: "Walk the cat", dueDate: Date(timeInterval: 45000, since: Date.now), priority: "1", category: .misc),
            Task(title: "Do handstands", dueDate: Date(timeInterval: 96880, since: Date.now), priority: "4", category: .misc),
        ]
    }
}
