//
//  LoginViewPresenterTests.swift
//  TodoList_MVPRTests
//
//  Created by Jason Ta on 2023-06-17.
//

import XCTest
@testable import TodoList_MVPR

final class LoginViewPresenterTests: XCTestCase {
    var sut: LoginViewPresenterProtocol!
    var controller = LoginViewControllerMock()
    var delegate = LoginViewPresenterDelegateMock()
    
    override func setUp() {
        sut = LoginViewPresenter(controller: controller,
                                 delegate: delegate)
    }
    // TESTING LOGIC OF ALERT
    func test_navToTodoListView() {
        sut.navToTodoListView()
        XCTAssertFalse(controller.presentAlertEventReceived)
        XCTAssertTrue(controller.isPasswordCorrect)
        XCTAssertTrue(delegate.navToTodoListScreenEventReceived)
    }
    // TESTING LOGIN LOGIC OF WRONG PASSWORD
    func test_didTapLoginButtonAlert() {
        let passwordTF = UITextField(size: CGSize())
        let usernameTF = UITextField(size: CGSize())
        sut.didTapLoginButton(passwordTextField: passwordTF, usernameTextField: usernameTF)
        
        XCTAssertTrue(controller.presentAlertEventReceived)
        XCTAssertFalse(controller.isPasswordCorrect)
        XCTAssertFalse(delegate.navToTodoListScreenEventReceived)
    }
}
