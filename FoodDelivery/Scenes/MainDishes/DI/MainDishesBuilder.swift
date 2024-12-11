//
//  MainDishesBuilder.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 11.12.2024.
//

struct MainDishesBuilder: IScreenBuilder {
    typealias ViewController = MainDishesViewController

    @Inject var mainDishesService: IMainDishesService
    @Inject var mainDishesMapper: IMainDishesMapper

    var dependencies: MainDishesViewModel.Dependencies {
        .init(mainDishesService: mainDishesService, mapper: mainDishesMapper)
    }
}
