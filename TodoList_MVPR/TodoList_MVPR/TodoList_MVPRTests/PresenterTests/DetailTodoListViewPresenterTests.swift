//
//  DetailTodoListViewPresenterTests.swift
//  TodoList_MVPRTests
//
//  Created by Jason Ta on 2023-06-17.
//

import XCTest
@testable import TodoList_MVPR

final class DetailTodoListViewPresenterTests: XCTestCase {
    var sut: TodoListEntryViewPresenterProtocol!
    var controller = DetailTodoListViewControllerMock()
    var delegate = DetailTodoListViewPresenterDelegateMock()
    //    var completion: (Task) -> Void
    
    override func setUp() {
        sut = TodoListEntryViewPresenter(controller: controller,
                                          delegate: delegate,
                                          completion: { _ in })
    }
    // TODO:
    func test_navAfterSaveWithAlert() {
        let alert = UIAlertController(title: "Missing Fields", message: "Please fill in the blank(s)", preferredStyle: .alert)
        sut.navToTodoListFromTodoListEntry()
        
        controller.presentAlert(alert)
        
        XCTAssertTrue(delegate.navToTodoListAfterSaveEventReceived)
    }
    
    func test_saveTask() {
        let alert = UIAlertController(title: "Missing Fields", message: "Please fill in the blank(s)", preferredStyle: .alert)
        let taskField = UITextField(size: CGSize())
        let dateTextField = UITextField(size: CGSize())
        let priorityTextField = UITextField(size: CGSize())
        sut.saveTask(taskField: taskField, dateTextField: dateTextField, priorityTextField: priorityTextField)
        
        guard let task = taskField.text,
              !task.isEmpty,
              let dateText = dateTextField.text,
              !dateText.isEmpty,
              let priorityText = priorityTextField.text,
              !priorityText.isEmpty
        else {
            controller.presentAlert(alert)
            XCTAssertTrue(controller.presentAlertEventReceived)
            XCTAssertFalse(delegate.navToTodoListAfterSaveEventReceived)
            return
        }
        delegate.navToTodoListAfterSave()
        XCTAssertFalse(controller.presentAlertEventReceived)
        XCTAssertTrue(delegate.navToTodoListAfterSaveEventReceived)
    }
    
    func test_formatDate() {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 6
        dateComponents.day = 1
        dateComponents.hour = 10
        dateComponents.minute = 10
        
        let dateToConvert = calendar.date(from: dateComponents) ?? Date()
        
        let expectedDate = "Jun 1 at 10:10 AM"
        
        let result = dateToConvert.dayAndTimeText
        
        XCTAssertEqual(result, expectedDate)
    }
    
}
