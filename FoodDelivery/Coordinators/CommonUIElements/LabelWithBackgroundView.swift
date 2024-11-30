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

    var background: UIColor {
        didSet {
            self.backgroundColor = background
        }
    }

    var cornerRadius: CGFloat {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    var font: UIFont
    var fontColor: UIColor
    var padding: UIEdgeInsets

    private lazy var ui = createUI()

    // MARK: - Initialization

    init(
        background: UIColor = .white,
        cornerRadius: CGFloat = .zero,
        font: UIFont = UIFont.systemFont(ofSize: 12),
        fontColor: UIColor = .black,
        padding: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    ) {
        self.background = background
        self.cornerRadius = cornerRadius
        self.font = font
        self.fontColor = fontColor
        self.padding = padding

        super.init(frame: .zero)
        self.clipsToBounds = true
    }

    // MARK: - Lifecycle

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        ui.label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(padding)
        }
    }

    override var intrinsicContentSize: CGSize {
        let labelSize = ui.label.sizeThatFits(.zero)
        let size = CGSize(
            width: labelSize.width + padding.left + padding.right,
            height: labelSize.height + padding.top + padding.bottom
        )
        return size
    }
}

private extension LabelWithBackgroundView {

    struct UI {
        let label: UILabel
    }

    func createUI() -> UI {

        let label = UILabel().setup {
            $0.textAlignment = .center
            $0.font = font
            $0.textColor = fontColor
            $0.numberOfLines = 1
            $0.text = text
            addSubview($0)
        }

        return .init(label: label)
    }
}
