//
//  RouterTests.swift
//  TodoList_MVPRTests
//
//  Created by Jason Ta on 2023-06-16.
//

import XCTest
@testable import TodoList_MVPR

final class RouterTests: XCTestCase {
    var sut: Router!
    var task: [Task] = []
    
    override func setUp() {
        sut = Router(taskSample: task)
    }
    // MARK: - TEST NAV TO TODOLISTVIEW -
    func test_navigateToTodoListView() {
        // GIVEN
        XCTAssertTrue(sut.navController.topViewController is LoginViewController)
        let expectation = XCTestExpectation(description: "wait for animation")
        // WHEN
        sut.navToTodoListScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
            expectation.fulfill()
        }

        // THEN
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(sut.navController.topViewController is TodoListViewController)
        XCTAssertEqual(sut.navController.viewControllers.count, 2)
    }
    // MARK: - TEST NAV TO LOGIN SCREEN FROM TODOLISTVIEW -
    func test_navigateToLoginScreen() {
        // GIVEN / ARRANGE
        XCTAssertTrue(sut.navController.topViewController is LoginViewController)
        let expectation = XCTestExpectation(description: "wait for animation")
        // WHEN
        sut.navToTodoListScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
            expectation.fulfill()
        }
        // THEN
        sut.navToLoginScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
        XCTAssertTrue(sut.navController.topViewController is LoginViewController)
        XCTAssertEqual(sut.navController.viewControllers.count, 1)
        }

    // MARK: - TEST NAV TO DETAILTODOLIST SCREEN FROM TODOLISTVIEW -
    func test_navigateToDetailTodoListScreen() {
        // GIVEN
        XCTAssertTrue(sut.navController.topViewController is LoginViewController)
        let expectation = XCTestExpectation(description: "wait for animation")
        // WHEN
        sut.navToTodoListScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            expectation.fulfill()
        }
        // THEN
        sut.navToEntryScreen(completion: { _ in })
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        XCTAssert(sut.navController.topViewController is TodoListEntryViewController)
        XCTAssertEqual(sut.navController.viewControllers.count, 3)
    }
    // MARK: - TEST NAV TO TODOLIST AFTER SAVE FROM DETAILTODOLIST -
    func test_navigateAfterSave() {
        // GIVEN
        XCTAssertTrue(sut.navController.topViewController is LoginViewController)
        let expectation = XCTestExpectation(description: "wait for animation")
        // WHEN
        sut.navToTodoListScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            expectation.fulfill()
        }
        sut.navToEntryScreen(completion: { _ in })
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            expectation.fulfill()
        }
        // THEN
        sut.navToTodoListAfterSave()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
        XCTAssertTrue(sut.navController.topViewController is TodoListViewController)
        XCTAssertEqual(sut.navController.viewControllers.count, 2)
    }
}



