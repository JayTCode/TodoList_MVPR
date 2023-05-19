//
//  LoginStackView.swift
//  TodoList-MVP-R
//
//  Created by Jason Ta on 2023-05-14.
//

import UIKit

extension UIView {
    
    fileprivate func Stack(_ axis: NSLayoutConstraint.Axis = .vertical, views: [UIView], spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        addSubview(stackView)
        return UIStackView()
    }
    
    @discardableResult
    public func VStack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        return VStack(axis: .vertical, views: views, spacing: CGFloat = 0, alignment: alignment, distribution: distribution)
    }
}
