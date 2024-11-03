//
//  RootContainer.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 03.11.2024.
//

import Swinject

final class RootContainer {
    static let shared = RootContainer()

    private let container = Container()

    private init() {}

    /// Регистрация зависимости
    func registerDependencies() {
        // Здесь регистрируем зависимости
    }

    /// Получение зависимости
    func resolve<T>(serviceType: T.Type) -> T? where T: AnyObject {
        return container.resolve(serviceType)
    }
}
