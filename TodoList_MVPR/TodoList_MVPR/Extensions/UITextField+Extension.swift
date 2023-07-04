//
//  UITextField+Extension.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-06-16.
//

import UIKit

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
        self.layer.cornerRadius = 10
        self.font = .systemFont(ofSize: 14)
        self.autocorrectionType = .no
        self.leftViewMode = .always
        self.setLeftPaddingPoints(10)
    }
}
