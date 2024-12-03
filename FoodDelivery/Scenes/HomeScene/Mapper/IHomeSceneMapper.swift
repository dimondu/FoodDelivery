//
//  IHomeSceneMapper.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 02.12.2024.
//

protocol IHomeSceneMapper {
    func map(_ response: HomeCategoryResponse) -> HomeCategoryTableViewCellModel
}
