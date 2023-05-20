//
//  TodoListViewCell.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-17.
//

import UIKit

class TodoListViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(priorityLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let title = UILabel(frame: CGRect(x: 20, y: 5, width: 280, height: 80))
        title.text = ""
        title.font = .preferredFont(forTextStyle: .headline)
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        title.clipsToBounds = true
        return title
    }()
    
    lazy var dateLabel: UILabel = {
        let date = UILabel(frame: CGRect(x: 20, y: 95, width: 280, height: 20))
        date.text = ""
        date.font = .preferredFont(forTextStyle: .subheadline)
        date.numberOfLines = 0
        date.clipsToBounds = true
        return date
    }()
    
    lazy var priorityLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 310, y: 45, width: 30, height: 30))
        label.text = ""
        label.clipsToBounds = true
        return label
    }()
    
    func set(data: TodoList) {
        titleLabel.text = data.title
        dateLabel.text = data.dueDate
        priorityLabel.text = data.priority
    }
    
    //    func constraints() {
    //        NSLayoutConstraint.activate([
    //            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
    //            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
    //            titleLabel.trailingAnchor.constraint(equalTo: priorityLabel.trailingAnchor, constant: -20),
    //            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    //        ])
    //    }
}
