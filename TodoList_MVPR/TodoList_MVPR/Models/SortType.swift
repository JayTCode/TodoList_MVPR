//
//  Sort.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-06-06.
//

import Foundation

enum SortType: Int {
    case byDate
    case byPriority
    case byAlpha
    
    var name: String {
        switch self {
        case .byDate:
            return NSLocalizedString("Date", comment: "Date style name")
        case .byPriority:
            return NSLocalizedString("Priority", comment: "Priority style name")
        case .byAlpha:
            return NSLocalizedString("Alpha", comment: "Alpha style name")
        }
    }
}
