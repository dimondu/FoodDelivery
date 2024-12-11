//
//  MainDishesAssembly.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 11.12.2024.
//

import Swinject

final class MainDishesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(IMainDishesService.self) { _ in
            MainDishesService()
        }

        container.register(IMainDishesMapper.self) { _ in
            MainDishesMapper()
        }
    }
}
