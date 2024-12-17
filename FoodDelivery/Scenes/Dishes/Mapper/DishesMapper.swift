//
//  DishesMapper.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 10.12.2024.
//

struct DishesMapper: IDishesMapper {
    func mapDishesCollectionCellModels(from source: [DishesResponse]) -> [DishesCollectionCellModel] {
        var result: [DishesCollectionCellModel] = []
        source.forEach {
            result.append(mapDishesCollectionCellModel(from: $0))
        }

        return result
    }
}

private extension DishesMapper {
    func mapDishesCollectionCellModel(from source: DishesResponse) -> DishesCollectionCellModel {
        DishesCollectionCellModel(id: source.id, imageUrl: source.imageUrl, title: source.title)
    }
}
