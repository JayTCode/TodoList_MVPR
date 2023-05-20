//
//  LoginViewController+TextFieldExtension.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-15.
//

import UIKit

//MARK: - UITEXTFIELD EXTENSION - 

extension UITextField {
 
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func textFieldShouldReturn(_ tetxField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
    
    public convenience init(size: CGSize) {
        self.init()
        self.backgroundColor = .tertiarySystemGroupedBackground
        self.clearButtonMode = .whileEditing
        self.layer.cornerRadius = 5
        self.font = .systemFont(ofSize: 14)
        self.autocorrectionType = .no
        self.leftViewMode = .always
        self.setLeftPaddingPoints(10)
    }
    
}

//MARK: - UIBUTTON EXTENSION -

extension UIButton {
    
    public convenience init(size: CGSize) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
//        let attributedString = NSMutableAttributedString(
//            attributedString: NSAttributedString(
//                string: "Save",
//                attributes: [
//                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
//                                                .foregroundColor: UIColor.white]))
//        self.setAttributedTitle(attributedString, for: .normal)]
        self.backgroundColor = .tertiarySystemGroupedBackground
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.clear, for: .highlighted)
    }
    
}
// MARK: - UILABEL EXTENSION -

extension UILabel {
    
    public convenience init(size: CGSize) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBackground
        self.textAlignment = .left
        self.textColor = UIColor.white
        self.font = .preferredFont(forTextStyle: .headline)
    }
}

//MARK: - KEYBOARD EXTENSION -

extension UIViewController {
    
    // Dismiss Keyboard Gesture for non-scrolling views
    func dismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

//MARK: - TOOLBAR ITEM -


