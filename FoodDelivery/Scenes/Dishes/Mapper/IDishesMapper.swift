//
//  IDishesMapper.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 10.12.2024.
//

protocol IDishesMapper {
    func mapDishesCollectionCellModels(from source: [DishesResponse]) -> [DishesCollectionCellModel]
}
