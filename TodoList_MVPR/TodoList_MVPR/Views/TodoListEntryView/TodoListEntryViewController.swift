//
//  DetailTodoListView.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-17.
//

import UIKit

protocol TodoListEntryViewControllerProtocol: AnyObject {
    var presenter: TodoListEntryViewPresenterProtocol? { get set }
    var selectedCategory: Category? { get set }
    func presentAlert(_ alert: UIAlertController)
}

final class TodoListEntryViewController: UIViewController, TodoListEntryViewControllerProtocol {
    var presenter: TodoListEntryViewPresenterProtocol?
    var selectedCategory: Category?
    
    // MARK: - VIEWDIDLOAD -
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    // PRESENT ALERT
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    //MARK: - BUTTON ACTIONS -
    @objc private func didTapSave() {
        presenter?.saveTask(taskField: taskField,
                            dateTextField: dateTextField,
                            priorityTextField: priorityTextField)
    }
    @objc private func backButtonPressed() {
        playSound(sound: "water_drop", type: "mp3")
        presenter?.navToTodoListFromTodoListEntry()
    }
    // MARK: - SETUP UI -
    private lazy var stackView = UIStackView(arrangedSubviews: [
        categoryLabel, categoryTextField,
        taskLabel, taskField,
        dateLabel, dateTextField,
        priorityLabel, priorityTextField,
        saveButton,
    ])
    // CATEGORY LABEL
    private lazy var categoryLabel = UILabel(size: CGSize())
    // CATEGORY TEXTFIELD AND PICKERVIEW
    private lazy var categoryTextField = UITextField(size: CGSize())
    private lazy var categoryPickerView = UIPickerView()
    // TASK LABEL AND TEXTFIELD
    private lazy var taskLabel = UILabel(size: CGSize())
    private lazy var taskField = UITextField(size: CGSize())
    // DATE LABEL, TEXTFIELD, & PICKERVIEW
    private lazy var dateLabel = UILabel(size: CGSize())
    private lazy var dateTextField = UITextField(size: CGSize())
    private lazy var datePickerView = UIDatePicker()
    // PRIORITY LABEL, TEXTFIELD, & PICKERVIEW
    private lazy var priorityLabel = UILabel(size: CGSize())
    private lazy var priorityTextField = UITextField(size: CGSize())
    private lazy var priorityPickerView = UIPickerView()
    // SAVE BUTTON
    private lazy var saveButton = UIButton(size: CGSize())
    // DONE BUTTON TOOLBAR FOR PICKERVIEWS
    private lazy var toolbar = UIToolbar()
    
    // MARK: - CONFIG UI -
    private func configUI() {
        view.backgroundColor = .systemBackground
        configNavBar()
        configStackView()
        configCategoryLabel()
        configCategoryTextField()
        configTaskLabel()
        configTaskField()
        configDateLabel()
        configDateTextField()
        configDatePickerView()
        configPriorityLabel()
        configPriorityTextField()
        configSaveButton()
        setupPickerViews()
        setupConstraints()
    }
    // CONFIGURE NAVBAR
    private func configNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonPressed))
        navigationItem.title = "Add New Task"
    }
    // CONFIGURE STACKVIEW
    private func configStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemBackground
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.layer.cornerRadius = 5
        stackView.spacing = 12
        view.addSubview(stackView)
    }
    // CONFIGURE CATEGORY LABEL
    private func configCategoryLabel() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.text = "Category"
    }
    // CONFIGURE CATEGORY TEXTFIELD
    private func configCategoryTextField() {
        categoryTextField.translatesAutoresizingMaskIntoConstraints = false
        categoryTextField.placeholder = "Tap to Pick Category"
        categoryTextField.clearButtonMode = .never
        categoryTextField.clearsOnInsertion = true
    }
    // CONFIGURE TASK LABEL
    private func configTaskLabel() {
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.text = "Task"
    }
    // CONFIGURE TASK TEXTFIELD
    private func configTaskField() {
        taskField.translatesAutoresizingMaskIntoConstraints = false
        taskField.placeholder = "Tap to Enter Task Name"
        taskField.clearButtonMode = .never
        dismissKeyboardGesture()
    }
    // CONFIGURE DATE LABEL
    private func configDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "Date"
    }
    // CONFIGURE DATE TEXTFIELD
    private func configDateTextField() {
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.placeholder = "Tap to Enter Date"
        dateTextField.clearButtonMode = .never
        dateTextField.clearsOnInsertion = true
    }
    // CONFIGURE DATE PICKERVIEW
    private func configDatePickerView() {
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .dateAndTime
        datePickerView.locale = .current
    }
    // CONFIGURE PRIORITY LABEL
    private func configPriorityLabel() {
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        priorityLabel.text = "Priority"
    }
    // CONFIGURE PRIORITY TEXTFIELD
    private func configPriorityTextField() {
        priorityTextField.translatesAutoresizingMaskIntoConstraints = false
        priorityTextField.placeholder = "Tap to pick priority of task"
        priorityTextField.clearButtonMode = .never
        priorityTextField.clearsOnInsertion = true
    }
    // CONFIGURE SAVE BUTTON
    private func configSaveButton() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(
            attributedString: NSAttributedString(
                string: "Save",
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    .foregroundColor: UIColor.white]))
        saveButton.setAttributedTitle(attributedString, for: .normal)
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    }
}
extension TodoListEntryViewController {
    //MARK: - UIPICKER TOOLBAR, DONEBUTTON, AND ACTIONS -
    private func setupPickerViews() {
        createCategoryPicker()
        createDatePicker()
        createPriorityPicker()
    }
    //MARK: - DONE BUTTON PRESSED ACTIONS: -
    @objc private func donePressed() {
        self.view.endEditing(true)
    }
    
    @objc private func dateDonePressed() {
        self.view.endEditing(true)
        dateTextField.text = "\(datePickerView.date.dayAndTimeText)"
    }
    //MARK: - CATEGORY PICKER TOOLBAR AND ACTIONS -
    private func configureDoneButton() {
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
    }
    
    private func createCategoryPicker() {
        configureDoneButton()
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryTextField.inputAccessoryView = toolbar
        categoryTextField.sizeToFit()
        categoryTextField.inputView = categoryPickerView
    }
    //MARK: - DATE PICKER TOOLBAR AND ACTIONS -
    private func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dateDonePressed))
        toolbar.setItems([doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.sizeToFit()
        dateTextField.inputView = datePickerView
    }
    //MARK: - PRIORITY PICKER TOOLBAR AND ACTIONS -
    private func createPriorityPicker() {
        configureDoneButton()
        priorityPickerView.translatesAutoresizingMaskIntoConstraints = false
        priorityPickerView.delegate = self
        priorityPickerView.dataSource = self
        priorityTextField.inputAccessoryView = toolbar
        priorityTextField.sizeToFit()
        priorityTextField.inputView = priorityPickerView
    }
}
// MARK: - UIPICKERVIEW DATASOURCE AND DELEGATE -
extension TodoListEntryViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPickerView {
            return presenter?.categories.count ?? 7
        } else if pickerView == priorityPickerView {
            return presenter?.priorityNumbers.count ?? 5
        }
        return 1
    }
    //MARK: - UIPICKERVIEW DELEGATE -
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPickerView {
            return presenter?.categories[row].rawValue
        } else if pickerView == priorityPickerView {
            return presenter?.priorityNumbers[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPickerView {
            selectedCategory = presenter?.categories[row]
            categoryTextField.text = presenter?.categories[row].rawValue
        } else if pickerView == priorityPickerView {
            priorityTextField.text = presenter?.priorityNumbers[row]
        }
    }
}

//MARK: - CONSTRAINTS -
extension TodoListEntryViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // STACKVIEW CONSTRAINTS
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // CATEGORY LABEL CONSTRAINTS
            categoryLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            categoryLabel.heightAnchor.constraint(equalToConstant: 30),
            // CATEGORY TEXTFIELD CONSTRAINTS
            categoryTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            categoryTextField.heightAnchor.constraint(equalToConstant: 40),
            // TASK LABEL CONSTRAINTS
            taskLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            taskLabel.heightAnchor.constraint(equalToConstant: 30),
            // TASK TEXTFIELD CONSTRAINTS
            taskField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            taskField.heightAnchor.constraint(equalToConstant: 40),
            // DATE LABEL CONSTRAINTS
            dateLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            // DATE TEXTFIELD CONSTRAINTS
            dateTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            dateTextField.heightAnchor.constraint(equalToConstant: 40),
            // PRIORITY LABEL CONSTRAINTS
            priorityLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            priorityLabel.heightAnchor.constraint(equalToConstant: 30),
            // PRIORITY TEXTFIELD CONSTRAINTS
            priorityTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            priorityTextField.heightAnchor.constraint(equalToConstant: 40),
            // SAVE BUTTON CONSTRAINTS
            saveButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -200),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        stackView.setCustomSpacing(2, after: categoryLabel)
        stackView.setCustomSpacing(2, after: taskLabel)
        stackView.setCustomSpacing(2, after: dateLabel)
        stackView.setCustomSpacing(2, after: priorityLabel)
        stackView.setCustomSpacing(10, after: priorityTextField)
    }
}



