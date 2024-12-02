//
//  HomeScreenBuilder.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

struct HomeScreenBuilder: IScreenBuilder {
    typealias ViewController = HomeViewController

    @Inject var homeCategoriesService: HomeCategoriesService
    @Inject var homeSceneMapper: HomeSceneMapper

    var dependencies: HomeViewModel.Dependencies {
        .init(homeCategoriesService: homeCategoriesService, homeSceneMapper: homeSceneMapper)
    }
}
