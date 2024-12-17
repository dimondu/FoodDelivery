//
//  DishesAssembly.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 11.12.2024.
//

import Swinject

final class DishesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(IDishesService.self) { _ in
            DishesService()
        }

        container.register(IDishesMapper.self) { _ in
            DishesMapper()
        }
    }
}
