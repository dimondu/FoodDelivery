//
//  NSObject+ISetupable.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 21.11.2024.
//

import Foundation

protocol ISetupable {}

extension ISetupable {

    @discardableResult
    func setup(closure: ((Self) -> Void)) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: ISetupable {}
