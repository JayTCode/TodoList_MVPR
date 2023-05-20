//
//  TodoList.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-16.
//

import Foundation

struct TodoList: Hashable {
    let id: UUID = UUID()
    let title: String
    let dueDate: String
    let priority: String?
    let category: Category?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension TodoList {
    static func sampleData() -> [TodoList] {
        return [
            TodoList(title: "Submit Financial Report to CFO", dueDate: Date(timeInterval: 400, since: Date.now).dayAndTimeText, priority: "4", category: .work),
            TodoList(title: "Submit taxes to CRA", dueDate: Date(timeInterval: 24500, since: Date.now).dayAndTimeText, priority: "2", category: .personal),
            TodoList(title: "Create grocery list", dueDate: Date(timeInterval: 1600, since: Date.now).dayAndTimeText, priority: "5", category: .errands),
            TodoList(title: "Walk the dog", dueDate: Date(timeInterval: 19000, since: Date.now).dayAndTimeText, priority: "3", category: .errands),
            TodoList(title: "Calculate how much it would cost to put down on mortgage in current economy", dueDate: Date(timeInterval: 30000, since: Date.now).dayAndTimeText, priority: "1", category: .fam),
            TodoList(title: "Walk the cat", dueDate: Date(timeInterval: 45000, since: Date.now).dayAndTimeText, priority: "1", category: .misc),
            TodoList(title: "Adopt a lion as a pet", dueDate: Date(timeInterval: 500000, since: Date.now).dayAndTimeText, priority: "2", category: .fun),
            TodoList(title: "Buy new shoes", dueDate: Date(timeInterval: 22000, since: Date.now).dayAndTimeText, priority: "3", category: .shopping),
        ]
    }
}
