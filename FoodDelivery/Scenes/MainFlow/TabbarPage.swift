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
			image = UIImage(systemName: "person.circle")
		case .home:
			image = UIImage(systemName: "house.circle")
		case .shoppingCart:
			image = UIImage(systemName: "cart.circle")
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
