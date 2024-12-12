//
//  IViewBindable.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 12.12.2024.
//

import UIKit

protocol IBindable: UIView {
    associatedtype Bindings
    func setupBindings(_ bindings: Bindings)
}

typealias IViewBindable = UIView & IBindable
