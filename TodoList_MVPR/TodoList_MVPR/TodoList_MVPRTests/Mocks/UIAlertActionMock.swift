//
//  UIAlertActionMock.swift
//  TodoList_MVPRTests
//
//  Created by Jason Ta on 2023-06-25.
//

import XCTest

class UIAlertActionMock: UIAlertAction {
    typealias Handler = ((UIAlertAction)-> Void)
    var handler: Handler?
    var mockTitle: String?
    var mockStyle: UIAlertViewStyle?
    
    convenience init(handler: Handler? = nil, mockTitle: String? = nil, mockStyle: UIAlertViewStyle? = nil) {
        self.init()
        self.handler = handler
        self.mockTitle = mockTitle
        self.mockStyle = mockStyle
    }
    override init() {
        mockStyle = .default
        super.init()
    }
}
