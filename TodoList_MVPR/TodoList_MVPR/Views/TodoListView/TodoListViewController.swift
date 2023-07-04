//
//  TodoListViewController.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-16.
//
import Foundation
import UIKit

protocol TodoListViewControllerProtocol: AnyObject {
    var presenter: TodoListViewPresenterProtocol? { get set }
    func presentTodoListViewSections(_ taskList: [Task])
    func deleteTask(_ indexPath: IndexPath, _ taskList: [Task])
    func presentAlert(_ alert: UIAlertController)
}

final class TodoListViewController: UIViewController, TodoListViewControllerProtocol, UITableViewDelegate {
    typealias DataSource = UITableViewDiffableDataSource<Category,Task>
    private var cellId = "cell"
    var dataSource: DataSource!
    var presenter: TodoListViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        presenter?.onViewDidLoad()
    }
    // PRESENT SECTIONS
    func presentTodoListViewSections(_ taskList: [Task]) {
        var snapshot = NSDiffableDataSourceSnapshot<Category,Task>()
        let _: [()] = presenter?.categories.map { category in
            let task = taskList.filter { $0.category == category }
            snapshot.appendSections([category])
            snapshot.appendItems(task)
        } ?? [()]
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    // PRESENT ALERT
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    //MARK: - UI ACTIONS -
    // ADD BUTTON PRESSED ACTION
    @objc private func addButtonPressed() {
        presenter?.didTapAddButton()
    }
    // LOGOFF BUTTON PRESSED ACTION
    @objc private func logoutButtonPressed() {
        presenter?.didTapLogout()
    }
    // SEGMENTED PRESSED SORTING ACTION
    @objc private func segmentPressed(_ sender: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            presenter?.sortBySegmentPressed(0)
        case 1:
            presenter?.sortBySegmentPressed(1)
        case 2:
            presenter?.sortBySegmentPressed(2)
        default:
            break
        }
    }
    // DELETE TASK
    func deleteTask(_ indexPath: IndexPath, _ taskList: [Task]) {
        var todoList = taskList
        let itemToDelete = dataSource.itemIdentifier(for: indexPath)
        todoList.removeAll(where: { $0.id == itemToDelete?.id } )
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([itemToDelete].compactMap { $0 })
        if let item = itemToDelete {
            todoList.removeAll(where: { $0 == item } )
        }
        presenter?.updateTodoList(with: todoList)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    // DELETE ITEM ACTION
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        presenter?.didSwipeToDeleteAt(indexPath: indexPath)
    }
    // MARK: - SETUP UI -
    // UI TABLEVIEW
    private lazy var tableView = UITableView(frame: view.bounds, style: .insetGrouped)
    // UI SEGMENTED CONTROL
    private lazy var segControl = UISegmentedControl(items: [SortType.byDate.name, SortType.byPriority.name, SortType.byAlpha.name])
    // MARK: - CONFIG UI -
    // CONFIG UI
    private func configUI() {
        view.backgroundColor = .systemBackground
        configDataSource()
        configTableView()
        configSegControl()
        configNavBar()
        updateConstraints()
    }
    // CONFIGURE DATASOURCE
    private func configDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, task) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath)
            cell.textLabel?.text = "\(task.title)\n\(task.dueDate.dayAndTimeText)\nPriority: \(task.priority)"
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 0
            return cell
        })
        dataSource.defaultRowAnimation = .fade
    }
    // CONFIGURE TABLEVIEW
    private func configTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(tableView)
    }
    // CONFIGURE SEG CONTROL
    private func configSegControl() {
        segControl.translatesAutoresizingMaskIntoConstraints = false
        segControl.backgroundColor = .tertiarySystemBackground
        segControl.selectedSegmentIndex = 0
        segControl.addTarget(self, action: #selector(segmentPressed(_:)), for: .valueChanged)
        view.addSubview(segControl)
    }
    // CONFIGURE NAVBAR
    private func configNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addButtonPressed))
        navigationItem.title = "To Do List"
        navigationItem.largeTitleDisplayMode = .always
    }
    // CONFIG HEADER IN SECTIONS
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = presenter?.categories[section].rawValue.capitalized
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}
// MARK: - CONSTRAINTS -
extension TodoListViewController {
    private func updateConstraints() {
        NSLayoutConstraint.activate([
            // TABLEVIEW CONSTRAINTS
            tableView.topAnchor.constraint(equalTo: segControl.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            // SEGMENTED CONTROL CONSTRAINTS
            segControl.heightAnchor.constraint(equalToConstant: 30),
            segControl.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -125),
            segControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            segControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
}
