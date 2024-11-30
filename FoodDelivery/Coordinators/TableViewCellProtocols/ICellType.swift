//
//  ICellType.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 21.11.2024.
//

protocol CellType {
    associatedtype CellModel: CellModelType
    static var identifier: String { get }
    func configure(with model: CellModel)
}
