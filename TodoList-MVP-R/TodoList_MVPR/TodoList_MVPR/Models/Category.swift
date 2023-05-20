//
//  Category.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-18.
//

import Foundation

enum Category: String, CaseIterable {
    case personal = "Personal"
    case work = "Work"
    case errands = "Errands"
    case shopping = "Shopping"
    case fun = "Fun"
    case fam = "Family"
    case misc = "Miscellaneous"
}
