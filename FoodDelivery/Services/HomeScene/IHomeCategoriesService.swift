//
//  IHomeCategoriesService.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 02.12.2024.
//

import Combine

protocol IHomeCategoriesService {
    func fetchCategories() -> AnyPublisher<[HomeCategoryResponse], Never>
}
