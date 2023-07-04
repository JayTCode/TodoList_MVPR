//
//  Router.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-16.
//

import UIKit

final class Router {
    let navController: UINavigationController
    var taskSample: [Task]
    
    init(_ navController: UINavigationController = UINavigationController(),
         taskSample: [Task]) {
        self.navController = navController
        self.taskSample = taskSample
        self.navController.viewControllers = [
            createLoginViewController(),
        ]
    }
    // CREATE LOGIN VC
    private func createLoginViewController() -> LoginViewController {
        let vc = LoginViewController()
        _ = LoginViewPresenter(controller: vc, delegate: self)
        return vc
    }
    // CREATE TODOLIST VC
    private func createTodoListViewController() -> TodoListViewController {
        let vc = TodoListViewController()
        _ = TodoListViewPresenter(controller: vc, delegate: self, taskList: taskSample)
        return vc
    }
    // CREATE DETAIL VC
    private func createTodoListEntryViewController(completion: @escaping (Task) -> Void) -> TodoListEntryViewController {
        let vc = TodoListEntryViewController()
        _ = TodoListEntryViewPresenter(controller: vc, delegate: self, completion: completion)
        return vc
    }
}
// MARK: - LOGIN VIEW PRESENTER DELEGATE -
extension Router: LoginViewPresenterDelegate {
    // NAVIGATE FROM LOGIN VC TO TODOLIST VC
    func navToTodoListScreen() {
        let todoListVC = createTodoListViewController()
        navController.pushViewController(todoListVC, animated: true)
    }
}
// MARK: - TODOLISTVIEW PRESENTER DELEGATE -
extension Router: TodoListViewPresenterDelegate {
    func navToLoginScreen() {
        navController.popViewController(animated: true)
    }
    // NAVIGATE TO DETAIL VC
    func navToEntryScreen(completion: @escaping (Task) -> Void) {
        let detailTodoListVC = createTodoListEntryViewController(completion: completion)
        navController.pushViewController(detailTodoListVC, animated: true)
    }
}
// MARK: - DETAILTODOLISTVIEW PRESENTER DELEGATE -
extension Router: TodoListEntryViewPresenterDelegate {
    // NAVIGATE FROM DETAIL VC TO TODOLIST VC
    func navToTodoListAfterSave() {
        navController.popViewController(animated: true)
    }
}
