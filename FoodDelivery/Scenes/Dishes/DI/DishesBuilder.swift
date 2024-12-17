//
//  DishesBuilder.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 11.12.2024.
//

struct DishesBuilder: IScreenBuilder {
    typealias ViewController = DishesViewController

    @Inject var dishesService: IDishesService
    @Inject var dishesMapper: IDishesMapper

    var dependencies: DishesViewModel.Dependencies {
        .init(dishesService: dishesService, mapper: dishesMapper)
    }
}
