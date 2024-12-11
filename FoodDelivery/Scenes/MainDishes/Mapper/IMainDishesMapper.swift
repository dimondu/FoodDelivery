//
//  IMainDishesMapper.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 10.12.2024.
//

protocol IMainDishesMapper {
    func mapDishesCollectionCellModels(from source: [MainDishesResponse]) -> [MainDishesCollectionCellModel]
}
