//
//  TodoListViewPresenter.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-06-02.
//
import Foundation
import UIKit
// MARK: - TODOLISTVIEW PRESENTER DELEGATE -
protocol TodoListViewPresenterDelegate: AnyObject {
    func navToEntryScreen(completion: @escaping (Task) -> Void)
    func navToLoginScreen()
}
// MARK: - TODOLISTVIEW PRESENTER PROTOCOL -
protocol TodoListViewPresenterProtocol: AnyObject {
    func onViewDidLoad()
    func didTapAddButton()
    func didTapLogout()
    func sortList(byType: SortType)
    func sortBySegmentPressed(_ selectedSegmentIndex: Int)
    func didSwipeToDeleteAt(indexPath: IndexPath) -> UISwipeActionsConfiguration?
    func updateTodoList(with newData: [Task])
    var categories: [Category] { get set }
}
// MARK: - TODOLISTVIEW PRESENTER -
final class TodoListViewPresenter: TodoListViewPresenterProtocol {
    private weak var controller: TodoListViewControllerProtocol?
    private var delegate: TodoListViewPresenterDelegate
    private var todoList: [Task]
    var categories: [Category] = [.personal, .work, .errands, .shopping, .fun, .family, .misc]

    init(controller: TodoListViewControllerProtocol,
         delegate: TodoListViewPresenterDelegate,
         taskList: [Task]) {
        self.controller = controller
        self.delegate = delegate
        self.todoList = taskList
        self.controller?.presenter = self
    }
    // MARK: - BUSINESS LOGIC -
    // VIEWDIDLOAD
    func onViewDidLoad() {
        sortList(byType: .byDate)
        controller?.presentTodoListViewSections(todoList)
    }
    // NAV TO ADD SCREEN
    func didTapAddButton() {
        playSound(sound: "notification", type: "mp3")
        delegate.navToEntryScreen { [weak self] task in
            guard let self = self else { return }
            self.todoList.append(task)
            self.sortList(byType: .byDate)
            self.controller?.presentTodoListViewSections(self.todoList)
        }
    }
    // LOGOFF BUTTON LOGIC
    func didTapLogout() {
        playSound(sound: "thriller", type: "mp3")
        let alert = UIAlertController(title: "Logout", message: "Do you wish to logout?", preferredStyle: .alert)
        let confirmLogout = UIAlertAction(title: "Logout", style: .destructive) { logout in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                playSound(sound: "exit", type: "mp3")
                self.delegate.navToLoginScreen()
            }
        }
        let cancelLogout = UIAlertAction(title: "Cancel", style: .cancel) { cancel in
            playSound(sound: "notification", type: "mp3")
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(confirmLogout)
        alert.addAction(cancelLogout)
        controller?.presentAlert(alert)
    }
    
    // APPEND FILTERED AND SORTED TASKS
    func sortList(byType: SortType) {
        var sortedTodoList: [Task] = []
        let _: [()] = categories.map { category in
            let taskList = todoList.filter( { $0.category == category } ).sorted {
                switch byType {
                case .byDate:
                    return  $0.dueDate < $1.dueDate
                case .byPriority:
                    return  $0.priority > $1.priority
                case .byAlpha:
                    return $0.title < $1.title
                }
            }
            sortedTodoList.append(contentsOf: taskList)
        }
        todoList = sortedTodoList
        }
    
    // SORTLIST BASED ON SEGMENTED CONTROL PRESSED
    func sortBySegmentPressed(_ selectedSegmentIndex: Int) {
        let sortStyle = SortType(rawValue: selectedSegmentIndex) ?? .byDate
        if sortStyle.rawValue == 0 {
            sortList(byType: .byDate)
        } else if sortStyle.rawValue == 1 {
            sortList(byType: .byPriority)
        } else if sortStyle.rawValue == 2 {
            sortList(byType: .byAlpha)
        }
        playSound(sound: "clean_fast_swoosh", type: "mp3")
        controller?.presentTodoListViewSections(todoList)
    }
    // UPDATE DATA MODEL
    func updateTodoList(with newData: [Task]) {
        todoList = newData
    }
    // DELETE ITEM LOGIC
    func didSwipeToDeleteAt(indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (delete, item, completion) in
            guard let self = self else { return }
            self.controller?.deleteTask(indexPath, self.todoList)
            playSound(sound: "swoosh_transition", type: "mp3")
            completion(true)
        }
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}
