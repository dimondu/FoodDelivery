//
//  UITableView+register.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 21.11.2024.
//

import UIKit

extension UITableView {
    func register(_ type: UITableViewCell.Type) {
        register(type, forCellReuseIdentifier: type.id)
    }
}
