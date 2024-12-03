//
//  UIImage+resize.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 30.11.2024.
//

import UIKit

extension UIImage {
    func resize(_ height: CGFloat) -> UIImage {
        let heightRatio = height / size.height

        let newSize = CGSize(
            width: size.width * heightRatio,
            height: size.height * heightRatio
        )

        let rect = CGRect(
            x: .zero,
            y: .zero,
            width: newSize.width,
            height: newSize.height
        )

        let format = UIGraphicsImageRendererFormat()
        format.scale = .zero
        format.opaque = false

        return UIGraphicsImageRenderer(size: newSize, format: format)
            .image { _ in
                draw(in: rect)
            }
    }
}
