//
//  TableViewCellConfigurations.swift
//  TodoList-MVP-R
//
//  Created by Jason Ta on 2023-05-12.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
}

extension TodoListViewController {
    
    private func doneButtonConfiguration(for todoLists: TodoList) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = todoLists.isComplete ? "circle.dashed.inset.filled" : "circle.dashed"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = TodoListDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = todoLists.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
    
    @objc func didPressDoneButton(_ sender: UIButton) {
        
    }
}
