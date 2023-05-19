//
//  ViewController.swift
//  TodoList-MVP-R
//
//  Created by Jason Ta on 2023-05-11.
//

import UIKit

class TodoListViewController: UIViewController, TodoListPresenterDelegate {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemCyan
        return tableView
    }()
    
    private let tableViewCell: UITableViewCell = {
        let tableViewCell = UITableViewCell()
        return tableViewCell
    }()
    
    var todoLists: [TodoList] = TodoList.sampleData
    var todoList: [TodoList] = []
    
    private let presenter = TodoListPresenter(todoList: TodoList.sampleData)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Table
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //Add Button
        navigationItem.title = "To Do List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(navigateToAddScreen))
        
        // Presenter
        presenter.setViewDelegate(delegate: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    @objc func navigateToAddScreen() {
        let addVC = TodoListDetailViewController()
        addVC.title = "To Do List"
        navigationController?.pushViewController(addVC, animated: true)
    }
    
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        _ = todoLists[indexPath.item]
        cell.textLabel?.text = todoLists[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Ask presenter to handle the tap
        
    }
    
    // Presenter Delegate
    func presentTodoList(todolist: [TodoList]) {
        self.todoLists = todolist
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}


