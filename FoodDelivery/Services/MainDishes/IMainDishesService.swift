//
//  IMainDishesService.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 10.12.2024.
//

import Combine

protocol IMainDishesService {
    func loadMainDishes() -> AnyPublisher<[MainDishesResponse], Never>
}
