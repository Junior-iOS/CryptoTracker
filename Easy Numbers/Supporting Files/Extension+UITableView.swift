//
//  Extension+UITableView.swift
//  Apple Music
//
//  Created by NJ Development on 11/05/23.
//

import Foundation
import UIKit

extension UITableView {
    func register(cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(of class: T.Type, for indexPath: IndexPath, configure: @escaping((T) -> Void) = { _ in }) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        if let typedCell = cell as? T {
            configure(typedCell)
        }
        return cell
    }
}
