//
//  Presenter.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-16.
//
import Foundation
import UIKit
// MARK: - LOGINVIEW PRESENTER DELEGATE -
protocol LoginViewPresenterDelegate: AnyObject {
    func navToTodoListScreen()
}
// MARK: - LOGINVIEW PRESENTER PROTOCOL -
protocol LoginViewPresenterProtocol: AnyObject {
    func navToTodoListView()
    func didTapLoginButton(passwordTextField: UITextField, usernameTextField: UITextField)
}
// MARK: - LOGINVIEW PRESENTER -
final class LoginViewPresenter: LoginViewPresenterProtocol {
    private weak var controller: LoginViewControllerProtocol?
    private var delegate: LoginViewPresenterDelegate
    
    init(controller: LoginViewControllerProtocol,
         delegate: LoginViewPresenterDelegate) {
        self.controller = controller
        self.delegate = delegate
        self.controller?.presenter = self
    }
// MARK: - BUSINESS LOGIC -
    // NAV TO TODOLIST DELEGATE
    func navToTodoListView() {
        delegate.navToTodoListScreen()
    }
    // LOGIN BUTTON LOGIC
    func didTapLoginButton(passwordTextField: UITextField, usernameTextField: UITextField) {
        if passwordTextField.text == "password" && ((usernameTextField.text?.isEmpty) != nil) {
            let _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [weak self] timer in
                passwordTextField.text = nil
                playSound(sound: "success", type: "mp3")
                self?.navToTodoListView()
            }
        } else {
            let alertWrongPassword = UIAlertController(title: "Incorrect Password", message: "Please Try Again", preferredStyle: .actionSheet)
            alertWrongPassword.addAction(UIAlertAction(title: "OK", style: .default))
            playSound(sound: "thriller", type: "mp3")
            controller?.presentAlert(alertWrongPassword)
        }
    }
}

// MARK: - FORMATTER -

//protocol FormatterProtocol: AnyObject {
//    func createSections() -> [Category]
//}
//
//final class Formatter: FormatterProtocol {
//
//    func createSections() -> [Category] {
//        // TODO Return an array of category to the tableview
//
//        return Category.allCases
//    }
//}
//        [.section([
//            .todoListRow(TodoList(title: "Submit taxes to CRA", dueDate: Date(timeInterval: 24500, since: Date.now).dayAndTimeText, priority: "2", category: .personal)),
//            .todoListRow(TodoList(title: "Create grocery list", dueDate: Date(timeInterval: 1600, since: Date.now).dayAndTimeText, priority: "5", category: .errands)),
//            .todoListRow(TodoList(title: "Walk the dog", dueDate: Date(timeInterval: 19000, since: Date.now).dayAndTimeText, priority: "3", category: .errands)),
//            .todoListRow(TodoList(title: "Calculate how much it would cost to put down on mortgage in current economy", dueDate: Date(timeInterval: 30000, since: Date.now).dayAndTimeText, priority: "1", category: .fam)),
//        ])]

