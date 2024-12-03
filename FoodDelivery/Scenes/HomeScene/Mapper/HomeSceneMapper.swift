//
//  HomeSceneMapper.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 02.12.2024.
//

struct HomeSceneMapper: IHomeSceneMapper {
    func map(_ response: HomeCategoryResponse) -> HomeCategoryTableViewCellModel {
        HomeCategoryTableViewCellModel(
            id: response.id,
            imageUrl: response.image,
            title: response.title,
            numberOfRatings: response.ratingsCount,
            rating: response.stars,
            priceStartsAt: response.priceStartsAt,
            promotionalOffer: response.promotionalOffer
        )
    }
}
