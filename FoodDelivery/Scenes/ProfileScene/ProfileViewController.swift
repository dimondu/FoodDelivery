//
//  PurpleViewController.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 27.10.2024.
//

import UIKit

class ProfileViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		let image: UIImageView = {
			let image = UIImage(systemName: "person.circle") ?? .actions
			let imageView = UIImageView(image: image)
			imageView.contentMode = .scaleAspectFit
			imageView.sizeToFit()
			imageView.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
			return imageView
		}()

		view.addSubview(image)
	}
}
