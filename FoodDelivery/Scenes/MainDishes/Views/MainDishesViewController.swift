//
//  MainDishesViewController.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 05.12.2024.
//

import UIKit

// MARK: - MainDishesViewController

final class MainDishesViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView = MainDishesView()

    // MARK: - Overriden methods

    override func loadView() {
        view = contentView
    }
}
