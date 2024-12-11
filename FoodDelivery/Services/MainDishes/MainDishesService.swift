//
//  MainDishesService.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 10.12.2024.
//

import Combine
import CombineMoya
import Moya

struct MainDishesService: IMainDishesService {
    // MARK: - Properties

    private let provider: MoyaProvider<MainDishesTarget>

    // MARK: - Init

    init(provider: MoyaProvider<MainDishesTarget> = MoyaProvider<MainDishesTarget>()) {
        self.provider = provider
    }

    // MARK: - Functions

    func loadMainDishes() -> AnyPublisher<[MainDishesResponse], Never> {
        provider.requestPublisher(.mainDishes)
            .map([MainDishesResponse].self)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
