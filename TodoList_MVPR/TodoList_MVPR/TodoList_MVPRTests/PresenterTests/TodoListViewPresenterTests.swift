//
//  PresenterTests.swift
//  TodoList_MVPRTests
//
//  Created by Jason Ta on 2023-06-16.
//

import XCTest
@testable import TodoList_MVPR

final class TodoListViewPresenterTests: XCTestCase {
    var sut: TodoListViewPresenterProtocol!
    var controller = TodoListViewControllerMock()
    var delegate = TodoListViewPresenterDelegateMock()
    var todoList: [Task] = []
    var dataSource: MockDataSource!
    var mockDataSource: MockDataSource!
    
    override func setUp() {
        sut = TodoListViewPresenter(controller: controller,
                                    delegate: delegate,
                                    taskList: todoList)
    }
    
    func test_onViewDidLoad() {
        sut.onViewDidLoad()
        
        XCTAssertTrue(controller.presentTodoListViewSectionsDataReceived)
        XCTAssertTrue(todoList == controller.sortedList)
    }
    
    func test_didTapAddButton() {
        sut.didTapAddButton()
        
        XCTAssertTrue(delegate.navToAddScreenEventReceived)
    }
    
    func presentLogoutAlertDialogue() {
        let alert = UIAlertController(title: "Warning: Logout", message: "Do you wish to logout?", preferredStyle: .alert)
        let confirmButton = UIAlertAction(title: "Confirm", style: .destructive)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(confirmButton)
        alert.addAction(cancelButton)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func test_PresentLogoutAlertDialogue() {
        self.presentLogoutAlertDialogue()
        sut.didTapLogout()
        let expectation = XCTestExpectation(description: "wait for animation")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            XCTAssertTrue(UIApplication.shared.keyWindow?.rootViewController?.presentedViewController is UIAlertController)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(controller.presentAlertEventReceived)
        XCTAssertFalse(delegate.navToLoginScreenEventReceived)
    }
    
    //    func test_didTapLogoutAlertConfirmPressed() {
    //        //GIVEN
    //        sut.didTapLogout()
    //        XCTAssertTrue(controller.presentAlertEventReceived)
    //        XCTAssertFalse(delegate.navToLoginScreenEventReceived)
    //        // WHEN
    //
    //        // THEN
    //    }
    
//    func test_didTapCancelOnLogoutAlert() {
//        sut.didTapLogout()
//        XCTAssertTrue(controller.presentAlertEventReceived)
//        XCTAssertFalse(delegate.navToLoginScreenEventReceived)
//        // how will test know when cancel was pressed?
//        XCTAssertTrue(controller.didTapCancelOnLogoutAlertEventReceived)
//        XCTAssertFalse(controller.didTapConfirmOnLogoutAlertEventReceived)
//    }
    
//    func test_didTapConfirmOnLogoutAlert() {
//        // GIVEN
//        sut.didTapLogout()
//        XCTAssertTrue(controller.presentAlertEventReceived)
//        XCTAssertFalse(delegate.navToLoginScreenEventReceived)
//        let expectation = XCTestExpectation(description: "waiting for animation")
//        // WHEN
//
//
//        // THEN
//        XCTAssertFalse(controller.didTapCancelOnLogoutAlertEventReceived)
//        XCTAssertTrue(controller.didTapConfirmOnLogoutAlertEventReceived)
//    }
    
    func test_sortList() {
        // WHAT CAN I TEST FOR SORT LIST FUNCTION?
        // WHAT DO I NEED TO IMPLEMENT IN THE MOCK TO TEST THE SORT LIST FUNCTION?
        sut.sortList(byType: .byDate)
        // CREATE A MOCK LIST TO SORT?
        
        sut.sortList(byType: .byAlpha)
        
        
        sut.sortList(byType: .byPriority)
        
        
    }
    // TEST EACH SEGMENT MANUALLY
    func test_sortBySegmentedPressed() {
        sut.sortBySegmentPressed(0)
        XCTAssertTrue(controller.presentTodoListViewSectionsDataReceived)
        XCTAssertTrue(todoList == controller.sortedList)
        
        sut.sortBySegmentPressed(1)
        XCTAssertTrue(controller.presentTodoListViewSectionsDataReceived)
        XCTAssertTrue(todoList == controller.sortedList)
        
        sut.sortBySegmentPressed(2)
        XCTAssertTrue(controller.presentTodoListViewSectionsDataReceived)
        XCTAssertTrue(todoList == controller.sortedList)
    }
    
    // TODO: TEST DELETE ITEM ACTION?
    // COMPARE THE EXPECTED LIST TO UPDATED LIST
    func test_didSwipeToDeleteAt() {
        // GIVEN
        let indexPath = IndexPath(row: 0, section: 0)
        let taskToDelete = Task.mockTaskArray[0]
        let taskList = [taskToDelete]
        
        // WHEN
        let expectedTodoList = Task.mockTaskArray
        controller.deleteTask(indexPath, taskList)
        
        // What's the expectation?
        // Expectation is that when didSwipeToDeleteAt function is called, the item at the indexPath selected will be deleted and the todoList will be updated.
        // What do I need to implement for the expectation to be true?
        // I need a todoList with an item to delete from; I need proof that the item at IndexPath was removed - dataSource itemIdentifier?
        // I need to compare the deletedItemIdentifier matches the item that was deleted from the todoList.
        // I need to compare the expectation to the actual result of deletion. So comparing expected todolist to updated todolist.
        
        // THEN
        
    }
    
    func test_updateTodoList() {
        // TEST TO SEE IF THE EXPECTED TODOLIST IS EQUAL TO THE UPDATED TODO LIST AFTER DELETING AN ITEM
        
    }
    // TODO: - TESTING OF DATASOURCE SNAPSHOT
    // COMPARE EXPECTED MOCK SNAPSHOT VS UPDATED MOCK SNAPSHOT
    // ADDING ITEM TO SNAPSHOT
    
    // DELETING ITEM FROM SNAPSHOT
}

