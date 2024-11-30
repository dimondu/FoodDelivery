//
//  ICellModelType.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 21.11.2024.
//

import Foundation

protocol CellModelType {
    var id: String { get }
}

extension CellModelType {
    var id: String {
        return String(describing: self)
    }
}
