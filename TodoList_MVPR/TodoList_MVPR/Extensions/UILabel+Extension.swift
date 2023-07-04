//
//  UILabel+Extension.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-06-16.
//

import UIKit

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
