//
//  HomeCategoriesService.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 28.11.2024.
//

import Combine
import CombineMoya
import Moya

struct HomeCategoriesService: IHomeCategoriesService {

    private let provider: MoyaProvider<HomeCategoriesAPI>

    init(provider: MoyaProvider<HomeCategoriesAPI> = MoyaProvider<HomeCategoriesAPI>()) {
        self.provider = provider
    }

    func fetchCategories() -> AnyPublisher<[HomeCategoryResponse], Never> {
        provider.requestPublisher(.fetchCategories)
            .map([HomeCategoryResponse].self)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
