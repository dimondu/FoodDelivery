//
//  RouterType.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 06.11.2024.
//

import UIKit

/// Протокол, под который подписывается роутер.
protocol RouterType {

    associatedtype TransitionHandler

    init(transitionHandler: TransitionHandler)
}

/// Пустой роутер для экранов без навигации.
final class EmptyRouter: RouterType {
    required init(transitionHandler: UIViewController) {}
}
