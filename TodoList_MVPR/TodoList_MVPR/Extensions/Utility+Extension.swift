//
//  LoginViewController+TextFieldExtension.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-15.
//

import UIKit

//MARK: - KEYBOARD EXTENSION -
extension UIViewController {
    // Dismiss Keyboard Gesture for non-scrolling views
    func dismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
