//
//  UITableViewCell+id.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 21.11.2024.
//

import UIKit

extension UITableViewCell {
    static var id: String {
        return String(describing: self)
    }
}
