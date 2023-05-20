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
            textField,
            dateTextField,
            saveButton,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .tertiarySystemGroupedBackground
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill // Changed from fillEqually
        stackView.layer.cornerRadius = 5
        stackView.spacing = 10
        return stackView
    }()
    
    // Category TextField & PickerView:
    private lazy var categoryTextField: UITextField = {
        let textField = UITextField(size: CGSize())
        textField.placeholder = "Tap to Pick Category"
        return textField
    }()
    
    private lazy var categoryPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    // Title Label & TextField
//    private lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Task"
//        label.font = .preferredFont(forTextStyle: .headline)
//        label.textAlignment = .left
//        label.textColor = .white
//        return label
//    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField(size: CGSize())
        textField.placeholder = "Task Name"
        return textField
    }()
    
    // Date Label, TextField, & DatePickerView
//    private lazy var dateLabel: UILabel = {
//        let label = UILabel()
//        label.font = .preferredFont(forTextStyle: .headline)
//        label.textAlignment = .left
//        label.textColor = .white
//        label.text = "Date"
//        return label
//    }()
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField(size: CGSize())
        textField.placeholder = "Tap to Enter Date"
        return textField
    }()
    
    private lazy var datePickerView: UIDatePicker = {
        let datePickerView = UIDatePicker()
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .dateAndTime
        datePickerView.locale = .current
        return datePickerView
    }()
    
    // Prioirty Label & Slider:
//    private lazy var priorityLabel: UILabel = {
//        let priorityLabel = UILabel()
//        priorityLabel.text = "Priority: "
//        priorityLabel.font = .preferredFont(forTextStyle: .largeTitle)
//        priorityLabel.textAlignment = .center
//        priorityLabel.textColor = .white
//        return priorityLabel
//    }()
    
    private lazy var priorityTextField: UITextField = {
        let textField = UITextField(size: CGSize())
        textField.placeholder = "Tap to pick priority between 1 (lowest priority) to 5 (highest priority)"
        return textField
    }()
    
    private lazy var prioritySlider: UISlider = {
        let prioritySlider = UISlider()
        prioritySlider.translatesAutoresizingMaskIntoConstraints = false
        prioritySlider.maximumValue = 5
        prioritySlider.minimumValue = 1
        prioritySlider.addTarget(self, action: #selector(prioiritySliderDidChange(_:)), for: .valueChanged)
        return prioritySlider
    }()
    
    // Save Button UIButton:
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        let attributedString = NSMutableAttributedString(
            attributedString: NSAttributedString(
                string: "Save",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                             .foregroundColor: UIColor.white]))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        return button
    }()
    
// MARK: - VIEWDIDLOAD() -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardGesture()
        view.backgroundColor = .tertiarySystemBackground
        view.addSubview(stackView)
        createDatePicker()
        setupConstraints()
    }
    
    //        stackView.setCustomSpacing(<#T##spacing: CGFloat##CGFloat#>, after: <#T##UIView#>) to use to customize spacing between views in stackview

    //MARK: - DATEPICKER ACTIONS -
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.sizeToFit()
        dateTextField.inputView = datePickerView
    }
    
    @objc func donePressed() {
        dateTextField.text = "\(datePickerView.date.dayAndTimeText)"
        self.view.endEditing(true)
    }
    
    //MARK: - PRIORITY SLIDER ACTIONS -
        
        @objc func prioiritySliderDidChange(_ sender: UISlider) {
            let roundedStepValue = round(sender.value)
            sender.value = roundedStepValue
            priorityTextField.text = "Prioirty: \(Int(roundedStepValue))"
        }
    
    //MARK: - SAVE BUTTON ACTION -
    
        @objc func didTapSave() {
            guard let title = textField.text,
                  !title.isEmpty,
                  let dateText = dateTextField.text,
                  !dateText.isEmpty,
                  let prioirty = priorityTextField.text,
                  !prioirty.isEmpty,
                  let selectedCategory = selectedCategory
            else {
                let alertMissingFields = UIAlertController(title: "Missing Fields", message: "Please fill in the missing fields", preferredStyle: .actionSheet)
                
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
        NSLayoutConstraint.activate([
    
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            //TitleLabel Constraints:
//            titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
//            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            //TextField Constraints:
            textField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 40),
//            textField.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/20),
            
            //DateLabel Constraints:
//            dateLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
//            dateLabel.heightAnchor.constraint(equalToConstant: 25),
//            dateLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/25),
            
            dateTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50),
            dateTextField.heightAnchor.constraint(equalToConstant: 40),

//            // Priority Label Constraints:
//            priorityLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 4/5),
//            priorityLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/25),
//            //Priority Picker Constraints:
//            prioritySlider.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 3/5),
//            prioritySlider.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/25),
//
//            // Save Button Constraints
//            saveButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 2/5),
//            saveButton.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/20),
        ])
    }
}

// MARK: - Category PickerView Datasource:
extension DetailTodoListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
}

//MARK: - Category PickerView Delegate:

extension DetailTodoListViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = Category.allCases[row]
    }
}
