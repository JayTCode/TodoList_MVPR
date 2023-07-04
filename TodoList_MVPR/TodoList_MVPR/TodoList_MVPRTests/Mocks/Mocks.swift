//
//  Mocks.swift
//  TodoList_MVPRTests
//
//  Created by Jason Ta on 2023-06-16.
//

import XCTest
@testable import TodoList_MVPR

// MARK: - LOGIN CONTROLLER MOCK: -
class LoginViewControllerMock: LoginViewControllerProtocol {
    private(set) var presentAlertEventReceived = false
    private(set) var isPasswordCorrect = true
    var presenter: TodoList_MVPR.LoginViewPresenterProtocol?
    
    func presentAlert(_ alert: UIAlertController) {
        isPasswordCorrect = false
        presentAlertEventReceived = true
    }
}
// MARK: - LOGIN PRESENTER DELEGATE MOCK: -
class LoginViewPresenterDelegateMock: LoginViewPresenterDelegate {
    private(set) var navToTodoListScreenEventReceived = false
    
    func navToTodoListScreen() {
        navToTodoListScreenEventReceived = true
    }
}
// MARK: - TODOLIST CONTROLLER MOCK: -
class TodoListViewControllerMock: TodoListViewControllerProtocol {
    private(set) var presentTodoListViewSectionsDataReceived = false
    private(set) var presentAlertEventReceived = false
    private(set) var deleteTaskEventReceived = false
    private(set) var updateListEventReceived = false
    private(set) var didTapConfirmOnLogoutAlertEventReceived = false
    private(set) var didTapCancelOnLogoutAlertEventReceived = false
    
    var presenter: TodoList_MVPR.TodoListViewPresenterProtocol?
    var sortedList: [Task]?
    
    func presentAlert(_ alert: UIAlertController) {
        presentAlertEventReceived = true
    }
    func presentTodoListViewSections(_ list: [TodoList_MVPR.Task]) {
        presentTodoListViewSectionsDataReceived = true
        sortedList = list
        updateListEventReceived = true
    }
    func deleteTask(_ indexPath: IndexPath, _ taskList: [TodoList_MVPR.Task]) {
        updateListEventReceived = true
        sortedList = taskList
        deleteTaskEventReceived = true
    }
    func didTapConfirmOnLogoutAlert() {
        didTapConfirmOnLogoutAlertEventReceived = true
        didTapCancelOnLogoutAlertEventReceived = false
    }
    func didTapCancelOnLogoutAlert() {
        didTapConfirmOnLogoutAlertEventReceived = false
        didTapCancelOnLogoutAlertEventReceived = true
    }
}
// MARK: - TODOLIST PRESENTER DELEGATE MOCK: -
class TodoListViewPresenterDelegateMock: TodoListViewPresenterDelegate {
    private(set) var navToAddScreenEventReceived = false
    private(set) var navToLoginScreenEventReceived = false
    private(set) var didTapConfirmOnLogoutAlertEventReceived = false
    
    func navToEntryScreen(completion: @escaping (TodoList_MVPR.Task) -> Void) {
        navToAddScreenEventReceived = true
        completion(Task.mockTask)
    }
    func navToLoginScreen() {
        navToLoginScreenEventReceived = true
    }
    func didTapConfirmOnLogoutAlert() {
        didTapConfirmOnLogoutAlertEventReceived = true
    }
}
// MARK: - DETAILTODOLIST CONTROLLER MOCK : -
class DetailTodoListViewControllerMock: TodoListEntryViewControllerProtocol {
    private(set) var presentAlertEventReceived = false
    
    var presenter: TodoList_MVPR.TodoListEntryViewPresenterProtocol?
    var selectedCategory: TodoList_MVPR.Category?
    
    func presentAlert(_ alert: UIAlertController) {
        presentAlertEventReceived = true
    }
}
// MARK: - DETAILTODOLIST PRESENTER DELEGATE MOCK: -
class DetailTodoListViewPresenterDelegateMock: TodoListEntryViewPresenterDelegate {
    private(set) var navToTodoListAfterSaveEventReceived = false
    
    func navToTodoListAfterSave() {
        navToTodoListAfterSaveEventReceived = true
    }
}
// MARK: - TASK MOCK -
extension Task {
    static var mockTask: Task {
        let task = Task(title: "Test Task", dueDate: Date.now, priority: "1", category: Category.personal)
        return task
    }
    static var mockTaskArray: [Task] {
        let taskArray = [
            Task(title: "Task #1", dueDate: Date.now, priority: "5", category: Category.personal),
            Task(title: "Task #2", dueDate: Date.now.addingTimeInterval(1000), priority: "4", category: Category.personal),
            Task(title: "Task #3", dueDate: Date.now.addingTimeInterval(2000), priority: "3", category: Category.personal)
        ]
        return taskArray
    }
}
// MARK: - DATASOURCE MOCK -
class MockDataSource: TodoListViewController.DataSource {
    var itemIdentifierResult: Task?
    
    override func itemIdentifier(for indexPath: IndexPath) -> Task? {
        return itemIdentifierResult
    }
}
