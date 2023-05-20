//
//  Presenter.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-16.
//

import Foundation

protocol LoginViewPresenterDelegate: AnyObject {
    func navigateToNextScreen()
}

protocol LoginViewPresenterProtocol: AnyObject {
    func didTapLogin()
}

// LoginViewControllerProtocol Initializer
final class Presenter: LoginViewPresenterProtocol {
    private weak var controller: LoginViewControllerProtocol?
    private let formatter: FormatterProtocol
    private var delegate: LoginViewPresenterDelegate
    
    init(controller: LoginViewControllerProtocol,
         formatter: FormatterProtocol,
         delegate: LoginViewPresenterDelegate) {
        self.controller = controller
        self.formatter = formatter
        self.delegate = delegate
        self.controller?.presenter = self
    }
    
    func didTapLogin() {
        delegate.navigateToNextScreen()
    }
}

// MARK: - TodoListViewPresenter -

protocol TodoListViewPresenterDelegate: AnyObject {
    func navigateToAddScreen()
}

protocol TodoListViewPresenterProtocol: AnyObject {
    func onViewDidLoad()
    func didTapAddButton()
}

final class TodoListPresenter: TodoListViewPresenterProtocol {
    
    private weak var controller: TodoListViewControllerProtocol?
    private let formatter: FormatterProtocol
    private var delegate: TodoListViewPresenterDelegate
    
    init(controller: TodoListViewControllerProtocol,
         formatter: FormatterProtocol,
         delegate: TodoListViewPresenterDelegate) {
        self.controller = controller
        self.formatter = formatter
        self.delegate = delegate
        self.controller?.presenter = self
    }
    
    func onViewDidLoad() {
        controller?.presentTodoListViewSections(formatter.createSections())
    }
    
    func didTapAddButton() {
        delegate.navigateToAddScreen()
    }
    
}

//MARK: - DetailTodoListView Presenter -

protocol DetailTodoListViewPresenterDelegate: AnyObject {
    func navigateToNextScreen()
}

protocol DetailTodoListViewPresenterProtocol: AnyObject {
    func didTapSaveButton()
}

final class DetailTodoListPresenter: DetailTodoListViewPresenterProtocol  {
    
    private weak var controller: DetailTodoListViewControllerProtocol?
    private let formatter: FormatterProtocol
    private var delegate: DetailTodoListViewPresenterDelegate
    
    init(controller: DetailTodoListViewControllerProtocol,
         formatter: FormatterProtocol,
         delegate: DetailTodoListViewPresenterDelegate) {
        self.controller = controller
        self.formatter = formatter
        self.delegate = delegate
        self.controller?.presenter = self
    }
    
    func didTapSaveButton() {
        delegate.navigateToNextScreen()
    }
    
}

// MARK: - FORMATTER -
protocol FormatterProtocol: AnyObject {
    func createSections() -> [Section]
}

final class Formatter: FormatterProtocol {
    
    func createSections() -> [Section] {
        [.main([
            .todoListRow(TodoList(title: "Submit taxes to CRA", dueDate: Date(timeInterval: 24500, since: Date.now).dayAndTimeText, priority: "2", category: .personal)),
            .todoListRow(TodoList(title: "Create grocery list", dueDate: Date(timeInterval: 1600, since: Date.now).dayAndTimeText, priority: "5", category: .errands)),
            .todoListRow(TodoList(title: "Walk the dog", dueDate: Date(timeInterval: 19000, since: Date.now).dayAndTimeText, priority: "3", category: .errands)),
            .todoListRow(TodoList(title: "Calculate how much it would cost to put down on mortgage in current economy", dueDate: Date(timeInterval: 30000, since: Date.now).dayAndTimeText, priority: "1", category: .fam)),
        ])]
    }
}
