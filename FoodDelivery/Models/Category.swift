//
//  Category.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 28.11.2024.
//

import Foundation

struct Category: Decodable {
    let id: String
    let title: String
    let image: String
    let ratingsCount: Int
    let stars: Double
    let priceStartsAt: Int
    let promotionalOffer: String?
}
