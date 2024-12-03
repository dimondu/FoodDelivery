//
//  CategoryResponse.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 28.11.2024.
//

import Foundation

struct HomeCategoryResponse: Decodable {
    let id: String
    /// Название категории
    let title: String
    /// Изображение для категории
    let image: String
    /// Количество оценок
    let ratingsCount: Int
    /// Рейтинг
    let stars: Double
    /// Цена с которой начинаются содержащиеся в категории блюда
    let priceStartsAt: Int
    /// Рекламное предложение
    let promotionalOffer: String?
}
