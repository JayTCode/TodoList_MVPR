//
//  DetailTodoListView.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-17.
//

import UIKit

protocol DetailTodoListViewControllerProtocol: AnyObject {
    var presenter: DetailTodoListViewPresenterProtocol? { get set }
}

protocol DetailTodoListViewControllerDelegate: AnyObject {
    func didAddDetailTodo(_ detailTodoViewController: DetailTodoListViewController, todoList: TodoList)
}

final class DetailTodoListViewController: UIViewController, DetailTodoListViewControllerProtocol {
    var presenter: DetailTodoListViewPresenterProtocol?
    
    weak var delegate: DetailTodoListViewControllerDelegate?
    
    private var selectedCategory: Category?
    
// MARK: - Setup Views -
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            categoryLabel, categoryTextField,
            taskLabel, taskField,
            dateLabel, dateTextField,
            priorityLabel, priorityTextField,
            saveButton,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemBackground
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill // Changed from fillEqually
        stackView.layer.cornerRadius = 5
        stackView.spacing = 12
        return stackView
    }()
    
    // Category Label:
    private lazy var categoryLabel: UILabel = {
        let label = UILabel(size: CGSize())
        label.text = "Category"
        return label
    }()
    
    // Category TextField & PickerView:
    private lazy var categoryTextField: UITextField = {
        let textField = UITextField(size: CGSize())
        textField.placeholder = "Tap to Pick Category"
        textField.clearButtonMode = .never
        return textField
    }()
    
    private lazy var categoryPickerView = UIPickerView()
    
//     Task Label & TextField
    private lazy var taskLabel: UILabel = {
        let label = UILabel(size: CGSize())
        label.text = "Task"
        return label
    }()
    
    private lazy var taskField: UITextField = {
        let textField = UITextField(size: CGSize())
        textField.placeholder = "Tap to Enter Task Name"
        return textField
    }()
    
//     Date Label, TextField, & DatePickerView
    private lazy var dateLabel: UILabel = {
        let label = UILabel(size: CGSize())
        label.text = "Date"
        return label
    }()
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField(size: CGSize())
        textField.placeholder = "Tap to Enter Date"
        textField.clearButtonMode = .never
        return textField
    }()
    
    private lazy var datePickerView: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.datePickerMode = .dateAndTime
        pickerView.locale = .current
        return pickerView
    }()
    
    // Prioirty Label & Slider:
    private lazy var priorityLabel: UILabel = {
        let priorityLabel = UILabel(size: CGSize())
        priorityLabel.text = "Priority"
        return priorityLabel
    }()
    
    private lazy var priorityTextField: UITextField = {
        let textField = UITextField(size: CGSize())
        textField.placeholder = "Tap to pick priority between 1 (lowest priority) to 5 (highest priority)"
        return textField
    }()
    
    private lazy var priorityPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    // Save Button UIButton:
    private lazy var saveButton: UIButton = {
        let button = UIButton(size: CGSize())
        let attributedString = NSMutableAttributedString(
            attributedString: NSAttributedString(
                string: "Save",
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                                                .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        return button
    }()
    
    // UIButton Extenssion with Attibutes
    
// MARK: - VIEWDIDLOAD() -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackView)
        setupConstraints()
        
        createCategoryPicker()
        createDatePicker()
        
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        selectedCategory = Category.allCases.first
    }
    
    //        stackView.setCustomSpacing(<#T##spacing: CGFloat##CGFloat#>, after: <#T##UIView#>) to use to customize spacing between views in stackview

    
    //MARK: - PICKER ACTIONS -
    
    // Category Picker Actions
    func createCategoryPicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(categoryDoneButton))
        toolbar.setItems([doneButton], animated: true)
        categoryTextField.inputAccessoryView = toolbar
        categoryTextField.sizeToFit()
        categoryTextField.inputView = categoryPickerView
    }
    
    @objc func categoryDoneButton() {
        self.view.endEditing(true)
    }
    
    // Date Picker
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dateDonePressed))
        toolbar.setItems([doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.sizeToFit()
        dateTextField.inputView = datePickerView
    }
    
    @objc func dateDonePressed() {
        dateTextField.text = "\(datePickerView.date.dayAndTimeText)"
        self.view.endEditing(true)
    }
    
// Priority Picker Actions
    
    
    //MARK: - SAVE BUTTON ACTION -
    
        @objc func didTapSave() {
            guard let title = taskField.text,
                  !title.isEmpty,
                  let dateText = dateTextField.text,
                  !dateText.isEmpty,
                  let prioirty = priorityTextField.text,
                  !prioirty.isEmpty,
                  let selectedCategory = selectedCategory
            else {
                let alertMissingFields = UIAlertController(title: "Missing Fields", message: "Please fill in the missing fields", preferredStyle: .actionSheet)
                alertMissingFields.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertMissingFields, animated: true, completion: nil)
                return
            }
            let todoList = TodoList(title: title, dueDate: dateText, priority: prioirty, category: selectedCategory)
            delegate?.didAddDetailTodo(self, todoList: todoList)
            self.presenter?.didTapSaveButton()
        }
    
}

//MARK: - CONSTRAINTS -
extension DetailTodoListViewController {
    func setupConstraints() {
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //StackView Constraints
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // Category Label Constraints:
            categoryLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            categoryLabel.heightAnchor.constraint(equalToConstant: 30),
            // Category TextField Constraints:
            categoryTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            categoryTextField.heightAnchor.constraint(equalToConstant: 40),
            
            //Task Label Constraints:
            taskLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            taskLabel.heightAnchor.constraint(equalToConstant: 30),
            //Task TextField Constraints:
            taskField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            taskField.heightAnchor.constraint(equalToConstant: 40),
            
            // DateLabel Constraints:
            dateLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            // Date TextField Constraints:
            dateTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            dateTextField.heightAnchor.constraint(equalToConstant: 40),

            // Prioirty Label Constraints:
            priorityLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            priorityLabel.heightAnchor.constraint(equalToConstant: 30),
            // Prioirty TextField Constraints:
            priorityTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            priorityTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Save Button Constraints
            saveButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1/2),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        // customer spacing for category textField after category label
        stackView.setCustomSpacing(2, after: categoryLabel)
        stackView.setCustomSpacing(2, after: taskLabel)
        stackView.setCustomSpacing(2, after: dateLabel)
        stackView.setCustomSpacing(2, after: priorityLabel)
    }
}

// MARK: - Category PickerView Datasource:
extension DetailTodoListViewController: UIPickerViewDataSource {
    func numberOfComponents(in categoryPickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ categoryPickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
}

//MARK: - Category PickerView Delegate:

extension DetailTodoListViewController: UIPickerViewDelegate {
    func pickerView(_ categoryPickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category.allCases[row].rawValue
    }
    
    func pickerView(_ categoryPickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = Category.allCases[row]
        categoryTextField.text = Category.allCases[row].rawValue
    }
    
}

//extension UIView {
//
//    func toolbarForPickerView() {
//    let toolbar = UIToolbar()
//    toolbar.sizeToFit()
//
//    guard let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(method))
//    toolbar.setItems([doneButton], animated: true)
//    }
//
//}
