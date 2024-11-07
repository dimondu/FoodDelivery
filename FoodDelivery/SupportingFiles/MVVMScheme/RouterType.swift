//
//  RouterType.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 06.11.2024.
//

import UIKit

/// Протокол, под который подписывается роутер.
protocol IRouterType {

    associatedtype TransitionHandler

    init(transitionHandler: TransitionHandler)
}

/// Пустой роутер для экранов без навигации.
final class EmptyRouter: IRouterType {
    required init(transitionHandler: UIViewController) {}
}
