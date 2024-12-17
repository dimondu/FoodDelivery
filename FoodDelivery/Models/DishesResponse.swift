//
//  DishesResponse.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 10.12.2024.
//

struct DishesResponse: Decodable {
    /// Идентификатор
    let id: String
    /// Cсылка на изображение
    let imageUrl: String
    /// Заголовок
    let title: String
}
