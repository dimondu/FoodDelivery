//
//  HomeRouter.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import UIKit

struct HomeRouter: IRouterType {
    
    let viewController: UIViewController
    
    init(transitionHandler: UIViewController) {
        viewController = transitionHandler
    }
}
