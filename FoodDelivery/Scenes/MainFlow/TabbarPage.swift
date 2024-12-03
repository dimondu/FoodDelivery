//
//  TabbarPage.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 27.10.2024.
//

import UIKit

enum TabbarPage: CaseIterable {
	case profile
	case home
	case shoppingCart

	func pageIconValue() -> UIImage {
		var image: UIImage?
		switch self {
		case .profile:
            image = UIImage(named: "person")
		case .home:
            image = UIImage(named: "home")
		case .shoppingCart:
            image = UIImage(named: "shopping_cart")
		}
		return image ?? .actions
	}

	static let initialTabbarPage: TabbarPage = .home

	var pageOrderNumber: Int {
		guard let number = TabbarPage.allCases.firstIndex(of: self) else {
			return .zero
		}
		return number
	}
}
