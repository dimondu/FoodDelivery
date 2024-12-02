//
//  RoundedBackgroundLabel.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 21.11.2024.
//

import SnapKit
import UIKit

final class LabelWithBackgroundView: UIView {
    // MARK: - Internal properties

    var text: String?

    var background: UIColor? {
        didSet {
            self.backgroundColor = background
        }
    }

    var cornerRadius: CGFloat? {
        didSet {
            self.layer.cornerRadius = cornerRadius ?? 0
        }
    }
    var font: UIFont?
    var fontColor: UIColor?
    var padding: UIEdgeInsets?

    // MARK: - Private properties
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = font
        label.textColor = fontColor
        label.numberOfLines = 1
        label.text = text
        addSubview(label)
        return label
    }()

    // MARK: - Lifecycle

    override func layoutSubviews() {
        self.clipsToBounds = true
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(padding ?? .zero)
        }
    }

    override var intrinsicContentSize: CGSize {
        let labelSize = label.sizeThatFits(.zero)
        guard let padding else { return labelSize }
        let size = CGSize(
            width: labelSize.width + padding.left + padding.right,
            height: labelSize.height + padding.top + padding.bottom
        )
        return size
    }
}
