//
//  HomeScreenBuilder.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

struct HomeScreenBuilder: IScreenBuilder {
    typealias ViewController = HomeViewController

    @Inject var categoriesService: CategoriesService

    var dependencies: HomeViewModel.Dependencies {
        .init(categoriesService: categoriesService)
    }
}
