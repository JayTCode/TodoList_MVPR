//
//  DetailTodoListViewPresenter.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-06-02.
//
import Foundation
import UIKit
// MARK: - TODOLISTENTRYVIEW PRESENTER DELEGATE -
protocol TodoListEntryViewPresenterDelegate: AnyObject {
    func navToTodoListAfterSave()
}
// MARK: - TODOLISTENTRYVIEW PRESENTER PROTOCOL -
protocol TodoListEntryViewPresenterProtocol: AnyObject {
    func navToTodoListFromTodoListEntry()
    func saveTask(taskField: UITextField, dateTextField: UITextField, priorityTextField: UITextField)
    var priorityNumbers: [String] { get }
    var categories: [Category] { get set }
}
// MARK: - TODOLISTENTRYVIEW PRESENTER -
final class TodoListEntryViewPresenter: TodoListEntryViewPresenterProtocol {
    private weak var controller: TodoListEntryViewControllerProtocol?
    private var delegate: TodoListEntryViewPresenterDelegate
    private var completion: (Task) -> Void
    var priorityNumbers = ["1", "2", "3", "4", "5"]
    var categories: [Category] = [.personal, .work, .errands, .shopping, .fun, .family, .misc]

    init(controller: TodoListEntryViewControllerProtocol,
         delegate: TodoListEntryViewPresenterDelegate,
         completion: @escaping (Task) -> Void) {
        self.controller = controller
        self.delegate = delegate
        self.completion = completion
        self.controller?.presenter = self
    }
// MARK: - BUSINESS LOGIC -
    // NAVIGATE TO TODOLIST AFTER SAVING
    func navToTodoListFromTodoListEntry() {
        delegate.navToTodoListAfterSave()
    }
    // SAVE TASK WHEN SAVE BUTTON PRESSED
    func saveTask(taskField: UITextField, dateTextField: UITextField, priorityTextField: UITextField) {
        guard let task = taskField.text,
              !task.isEmpty,
              let dateText = dateTextField.text,
              !dateText.isEmpty,
              let priorityText = priorityTextField.text,
              !priorityText.isEmpty,
              let selectedCategory = controller?.selectedCategory
        else {
            let alertMissingFields = UIAlertController(title: "Missing Fields", message: "Please fill in the missing fields", preferredStyle: .actionSheet)
            alertMissingFields.addAction(UIAlertAction(title: "OK", style: .default))
            playSound(sound: "failure_drum", type: "mp3")
            controller?.presentAlert(alertMissingFields)
            return
        }
        let taskEntry = Task(title: task, dueDate: Date(), priority: priorityText, category: selectedCategory)
        playSound(sound: "success", type: "mp3")
        completion(taskEntry)
        navToTodoListFromTodoListEntry()
    }
}
