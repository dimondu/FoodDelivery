//
//  Inject.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 04.11.2024.
//

import Swinject

// swiftlint:disable force_unwrapping
@propertyWrapper
struct Inject<Component> {

    let wrappedValue: Component

    init() {
        self.wrappedValue = Assembler.default.resolver.resolve(Component.self)!
    }
}
// swiftlint:enable force_unwrapping
