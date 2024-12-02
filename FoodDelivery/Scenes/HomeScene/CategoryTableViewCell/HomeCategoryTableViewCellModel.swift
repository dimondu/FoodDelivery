//
//  HomeCategoryTableViewCellModel.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 02.12.2024.
//

struct HomeCategoryTableViewCellModel: Hashable {
    let id: String
    let imageUrl: String
    let title: String
    let numberOfRatings: Int
    let rating: Double
    let priceStartsAt: Int
    let promotionalOffer: String?
}
