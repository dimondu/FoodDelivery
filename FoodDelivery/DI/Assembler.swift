//
//  Assembler.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 04.11.2024.
//

import Swinject

extension Assembler {
    static var `default`: Assembler {
        get {
            if assembler == nil {
                assembler = buildAssembler()
            }
            return assembler ?? Assembler()
        }

        set {
            assembler = newValue
        }
    }

    static var assembler: Assembler?

    private static func buildAssembler() -> Assembler {
        Assembler(allAssemblies)
    }

    private static var allAssemblies: [Assembly] {
        [
            HomeCategoriesServiceAssembly(),
            HomeSceneMapperAssembly()
            // Сюда добавлять Assembly модулей
        ]
    }
}
