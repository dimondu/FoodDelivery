//
//  UIImageView + setImage.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 11.12.2024.
//

import Kingfisher
import UIKit

public extension UIImageView {
    /// Метод загрузки и установки изображения
    ///
    /// - Parameters:
    ///  - urlString - URL-адрес
    ///  - placeholder - заглушка на случай, если URL некоррекнтый, пустой
    ///  - acivityIndacator - индикатор загрузки изображения
    func setImage(
        with urlString: String?,
        placeholder: UIImage? = nil,
        acivityIndacator: UIActivityIndicatorView? = nil
    ) {
        guard let urlString, !urlString.isEmpty, let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        acivityIndacator?.startAnimating()
        kf.setImage(with: url) { _ in
            acivityIndacator?.stopAnimating()
        }
    }
}
