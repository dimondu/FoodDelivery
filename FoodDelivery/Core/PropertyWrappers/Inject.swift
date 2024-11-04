//
//  Inject.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 04.11.2024.
//

import Swinject

@propertyWrapper
struct Inject<Component> {

    let wrappedValue: Component

    init() {
        self.wrappedValue = Assembler.default.resolver.resolve(Component.self)!
    }
}
