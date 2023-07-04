//
//  UIButton+Extension.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-06-16.
//

import UIKit

extension UIButton {
    public convenience init(size: CGSize) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .tertiarySystemGroupedBackground
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(gray: 0.9, alpha: 0.7)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.clear, for: .selected)
    }
}
