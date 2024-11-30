//
//  CategoriesServiceAssembly.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 30.11.2024.
//

import Swinject

final class CategoriesServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CategoriesService.self) { _ in
            CategoriesService()
        }
    }
}
