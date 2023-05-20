//
//  TodoListViewController.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-16.
//

import UIKit

protocol TodoListViewControllerProtocol: AnyObject {
    var presenter: TodoListViewPresenterProtocol? { get set }
    
    func presentTodoListViewSections(_ categories: [Category])
}

final class TodoListViewController: UIViewController, TodoListViewControllerProtocol {
    var presenter: TodoListViewPresenterProtocol?
    
    private let identifier = "cell"
    
    private var dataSource: DataSource!
    
    private var categories: [Category] = []
    
    private var categorySample = [Category]()
    
    var isAddingNewTodoList = false
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .systemGroupedBackground
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        return tableView
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton))
        return addButton
    }()
    
    private lazy var segControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["Date", "Priority", "Alpha"])
        segControl.selectedSegmentIndex = 1
        segControl.backgroundColor = .tertiarySystemBackground
        segControl.addTarget(self, action: #selector(selectedSegmentIndex(_:)), for: .valueChanged)
        return segControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(segControl)
        
        configureNavBar()
        
        updateConstraints()
        
        configureDataSource()
    }
    
    func presentTodoListViewSections(_ categories: [Category]) {
        self.categories = categories
//        updateSnapshot()
    }
    
    // MARK: - DATASOURCE -
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, todolist) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "\(todolist.title)"
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 0
            return cell
        })
        
        dataSource.defaultRowAnimation = .fade
        
        var snapshot = NSDiffableDataSourceSnapshot<Category, TodoList>()
        for category in Category.allCases {
            let todolists = TodoList.sampleData().filter { $0.category == category }
            snapshot.appendSections([category])
            snapshot.appendItems(todolists)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    //MARK: - ACTIONS -
    
    @objc func didPressAddButton() {
        navigationController?.pushViewController(DetailTodoListViewController(), animated: true)
    }
    
    @objc func selectedSegmentIndex(_ sender: UISegmentedControl) {
        print("Selected Segment Index: \(sender.selectedSegmentIndex)")
        // TODO filter the tableview to re-organize itself based on what was clicked - Date (closet to current date to later), Priority (highest priority to lowest), and Alphabetical(descending order) -
    }
    
    //MARK: - CONFIGURE NAVBAR -
    func configureNavBar() {
        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = "To Do List"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
    }
    
}
//MARK: - VIEW CONSTRAINTS -
extension TodoListViewController {
    func updateConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        segControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segControl.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            segControl.heightAnchor.constraint(equalToConstant: 30),
            segControl.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -125),
            segControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            segControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),

        ])
    }
}

// MARK: - DetailTodoListViewControllerDelegate - Update snapshot after add item.

extension TodoListViewController: DetailTodoListViewControllerDelegate {
    
    func didAddDetailTodo(_ detailTodoViewController: DetailTodoListViewController, todoList: TodoList) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([todoList], toSection: todoList.category)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

