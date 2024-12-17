//
//  IDishesService.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 10.12.2024.
//

import Combine

protocol IDishesService {
    func loadDishes() -> AnyPublisher<[DishesResponse], Never>
}
