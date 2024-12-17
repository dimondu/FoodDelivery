//
//  DishesService.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 10.12.2024.
//

import Combine
import CombineMoya
import Moya

struct DishesService: IDishesService {
    // MARK: - Properties

    private let provider: MoyaProvider<DishesTarget>

    // MARK: - Init

    init(provider: MoyaProvider<DishesTarget> = MoyaProvider<DishesTarget>()) {
        self.provider = provider
    }

    // MARK: - Functions

    func loadDishes() -> AnyPublisher<[DishesResponse], Never> {
        provider.requestPublisher(.dishes)
            .map([DishesResponse].self)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
