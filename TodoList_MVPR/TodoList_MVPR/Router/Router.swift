//
//  Router.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-16.
//

import UIKit

final class Router: LoginViewPresenterDelegate, TodoListViewPresenterDelegate, DetailTodoListViewPresenterDelegate {
    
    let navController: UINavigationController
    
    init(_ navController: UINavigationController = UINavigationController()) {
        
        self.navController = UINavigationController()
        self.navController.viewControllers = [createDetailTodoListViewController()] //change back to createLoginViewController after testing
    }
    
    // MARK: - NAVIGATION -
    func navigateToNextScreen() {
        navController.pushViewController(TodoListViewController(), animated: true)
    }
    
    func navigateToAddScreen() {
        navController.pushViewController(DetailTodoListViewController(), animated: true)
    }
    
    //    func navigateToNextScreen() {
    //        navController.pushViewController(TodoListViewController(), animated: true)
    //    }
    
    // MARK: - CREATE NEW VIEWCONTROLLERS -
    
    private func createLoginViewController() -> LoginViewController {
        let vc = LoginViewController()
        _ = Presenter(controller: vc, formatter: Formatter(), delegate: self)
        return vc
    }
    
    
    private func createTodoListViewController() -> TodoListViewController {
        let vc = TodoListViewController()
        _ = TodoListPresenter(controller: vc, formatter: Formatter(), delegate: self)
        return vc
    }
    
    private func createDetailTodoListViewController() -> DetailTodoListViewController {
        let vc = DetailTodoListViewController()
        _ = DetailTodoListPresenter(controller: vc, formatter: Formatter(), delegate: self)
        return vc
    }
    
}
