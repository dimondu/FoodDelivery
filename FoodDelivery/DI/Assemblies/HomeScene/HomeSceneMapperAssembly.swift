//
//  HomeSceneMapperAssembly.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 02.12.2024.
//

import Swinject

final class HomeSceneMapperAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeSceneMapper.self) { _ in
            HomeSceneMapper()
        }
    }
}
