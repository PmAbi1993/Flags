//
//  Tableview + Configs.swift
//  Flags
//
//  Created by admin on 18/07/21.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cells: [T.Type]) {
        cells.forEach({ register($0.self,
                                 forCellReuseIdentifier: String(describing: $0.self)) })
    }
    func dequedCell<T>(type: T.Type) -> T {
        guard let cell: T =  dequeueReusableCell(withIdentifier: String(describing: type)) as? T else {
            fatalError()
        }
        return cell
    }
}
