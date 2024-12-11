//
//  MainDishesMapper.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 10.12.2024.
//

struct MainDishesMapper: IMainDishesMapper {
    func mapDishesCollectionCellModels(from source: [MainDishesResponse]) -> [MainDishesCollectionCellModel] {
        var result: [MainDishesCollectionCellModel] = []
        source.forEach {
            result.append(mapDishesCollectionCellModel(from: $0))
        }

        return result
    }
}

private extension MainDishesMapper {
    func mapDishesCollectionCellModel(from source: MainDishesResponse) -> MainDishesCollectionCellModel {
        MainDishesCollectionCellModel(id: source.id, imageUrl: source.imageUrl, title: source.title)
    }
}
