//
//  TodoListViewPresenterMock.swift
//  TodoList_MVPRTests
//
//  Created by Jason Ta on 2023-06-25.
//
//
//import XCTest
//@testable import TodoList_MVPR
//
//class TodoListViewPresenterMock: TodoListViewPresenterProtocol {
//    var expectedTodoList: [Task]?
//    var updateTodoListCalledCount = 0
//    var updatedTodoList: [Task]?
//
//    func onViewDidLoad() {
//        <#code#>
//    }
//
//    func didTapAddButton() {
//        <#code#>
//    }
//
//    func didTapLogout() {
//        <#code#>
//    }
//
//    func sortList(byType: TodoList_MVPR.SortType) {
//        <#code#>
//    }
//
//    func sortBySegmentPressed(_ selectedSegmentIndex: Int) {
//        <#code#>
//    }
//
//    func didSwipeToDeleteAt(indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
//
//    func updateTodoList(with newData: [TodoList_MVPR.Task]) {
//        updateTodoListCalledCount += 1
//        updatedTodoList = newData
//    }
//
//    var categories: [TodoList_MVPR.Category] = [.personal, .work, .errands, .shopping, .fun, .family, .misc]
//}
