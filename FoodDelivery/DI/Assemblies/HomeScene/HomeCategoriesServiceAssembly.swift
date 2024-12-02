//
//  HomeCategoriesServiceAssembly.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 30.11.2024.
//

import Swinject

final class HomeCategoriesServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeCategoriesService.self) { _ in
            HomeCategoriesService()
        }
    }
}
