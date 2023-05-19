//
//  TodoListPresenter.swift
//  TodoList-MVP-R
//
//  Created by Jason Ta on 2023-05-11.
//

import Foundation
import UIKit

protocol TodoListPresenterDelegate: AnyObject {
    
}

protocol TodoListPresenterProtocol: AnyObject {
    func onViewDidLoad()
    func didTapOnCell()
}



typealias PresenterDelegate = TodoListPresenterDelegate & UIViewController

class TodoListPresenter {
    
    weak var delegate: PresenterDelegate?
    
    let navigationController = UINavigationController()
    
    var todoList: [TodoList] = TodoList.sampleData
    
    init(delegate: PresenterDelegate? = nil, todoList: [TodoList]) {
        self.delegate = delegate
        self.todoList = todoList
    }
    
    public func getTodoList() -> [TodoList] {
        let todoLists = TodoList.sampleData
        return todoLists
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }

}
