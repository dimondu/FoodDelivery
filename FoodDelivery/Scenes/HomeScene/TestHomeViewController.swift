//
//  TestHomeViewController.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 21.10.2024.
//

import UIKit

class TestHomeViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		let image: UIImageView = {
			let image = UIImage(systemName: "house.circle") ?? .actions
			let imageView = UIImageView(image: image)
			imageView.contentMode = .scaleAspectFit
			imageView.sizeToFit()
			imageView.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
			return imageView
		}()

		view.addSubview(image)
	}
}
