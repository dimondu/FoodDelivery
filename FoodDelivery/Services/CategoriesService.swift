//
//  CategoriesService.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 28.11.2024.
//

import Combine
import CombineMoya
import Foundation
import Moya

struct CategoriesService {

    private let provider: MoyaProvider<API>

    init(provider: MoyaProvider<API> = MoyaProvider<API>()) {
        self.provider = provider
    }

    func fetchCategories() -> AnyPublisher<[Category], Never> {
        provider.requestPublisher(.fetchCategories)
            .map([Category].self)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
