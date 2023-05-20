//
//  TodoList+Section.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-16.
//

import Foundation
import UIKit

enum Section: Hashable {
        case main([Row])

        var id: String {
            switch self {
            case .main:
                return "headerSection"
            }
        }
        
        var rows: [Row] {
            switch self {
            case let .main(rows):
                return rows
            }
        }
    }
    
enum Row: Hashable {
    case todoListRow(TodoList)
    
    var id: String {
        switch self {
        case .todoListRow(let model):
            return "intSection" + " \(model.title) \(model.dueDate) \(model.priority ?? "1")"
        }
    }
}
    

