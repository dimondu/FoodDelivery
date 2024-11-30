//
//  HomeRouter.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import UIKit

struct HomeRouter: IRouterType {
    private let router: Router

    init(transitionHandler: UIViewController) {
        router = Router(transitionHandler: transitionHandler)
    }
}
