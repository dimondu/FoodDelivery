//
//  TabBarController.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 27.10.2024.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension TabBarController {
    func setup() {
        let controllers: [UINavigationController] = TabbarPage.allCases
            .map(getTabBarController)

        setViewControllers(controllers, animated: true)
        selectedIndex = TabbarPage.initialTabbarPage.pageOrderNumber

        let topBorder = UIView()
        topBorder.backgroundColor = .lightGray

        topBorder.frame = CGRect(
            x: 28,
            y: 0,
            width: tabBar.frame.width - 56,
            height: 3
        )
        tabBar.addSubview(topBorder)

        tabBar.backgroundColor = UIColor(
            red: 251 / 255,
            green: 242 / 255,
            blue: 240 / 255,
            alpha: 1
        )

        tabBar.barTintColor = UIColor(
            red: 251 / 255,
            green: 242 / 255,
            blue: 240 / 255,
            alpha: 1
        )
        tabBar.clipsToBounds = true
    }

    func getTabBarController(_ page: TabbarPage) -> UINavigationController {
        let navigationController = UINavigationController()

        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: page.pageIconValue()
                .resize(32)
                .withRenderingMode(.alwaysOriginal),
            tag: page.pageOrderNumber
        )

        let tabbarPageInsets = getInsetsForTabbarPage(page)

        navigationController.tabBarItem.imageInsets = tabbarPageInsets

        return navigationController
    }
}

private extension TabBarController {

    func getInsetsForTabbarPage(_ page: TabbarPage) -> UIEdgeInsets {
        switch page {
        case .profile:
            UIEdgeInsets(top: 6, left: 32, bottom: -6, right: -32)
        case .home:
            UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        case .shoppingCart:
            UIEdgeInsets(top: 6, left: -32, bottom: -6, right: 32)
        }
    }
}
