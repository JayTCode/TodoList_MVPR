//
//  TodoListRouter.swift
//  TodoList-MVP-R
//
//  Created by Jason Ta on 2023-05-11.
//

import UIKit

final class TodoListRouter: PresenterDelegate {
    func navigateToNextScreen() {
        navigationController?.pushViewController(TodoListViewController(), animated: true)
    }
    
    
    let navController = UINavigationController()
    
}
