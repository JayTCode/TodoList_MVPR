//
//  TodoListDetailViewController.swift
//  TodoList-MVP-R
//
//  Created by Jason Ta on 2023-05-12.
//

import UIKit

class TodoListDetailViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoListDetailViewController.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
    }
}
