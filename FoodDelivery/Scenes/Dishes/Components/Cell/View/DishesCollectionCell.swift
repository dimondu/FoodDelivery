//
//  DishesCollectionCell.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 06.12.2024.
//

import SnapKit
import UIKit

// MARK: - Constants

private enum Constants {
    enum Button {
        static let backgroundColor = UIColor(red: 255, green: 120, blue: 91, alpha: 1)
        static let cornerRadius: CGFloat = 6
        static let fontSize: CGFloat = 8
        static let title = "Buy Now"
    }
    enum Label {
        static let bottomOffset: CGFloat = 15
        static let fontSize: CGFloat = 17
        static let topOffset: CGFloat = 23
    }
    enum Image {
        static let cornerRadius: CGFloat = 45
        static let height: CGFloat = 117
        static let topOffset: CGFloat = 15
    }
    static let identifier = "DishesCollectionCell"
    static let horizontalOffset: CGFloat = 16
}

// MARK: - DishesCollectionCell

final class DishesCollectionCell: UICollectionViewCell {
    // MARK: - Properties

    static let identifier = Constants.identifier

    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Light", size: Constants.Button.fontSize)
        button.backgroundColor = Constants.Button.backgroundColor
        button.layer.cornerRadius = Constants.Button.cornerRadius
        button.setTitle(Constants.Button.title, for: .normal)
        button.addTarget(DishesCollectionCell.self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.Image.cornerRadius
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let label: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: Constants.Label.fontSize)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()

    // MARK: - Init

    init() {
        super.init(frame: .zero)

        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DishesCollectionCell {
    @objc func buttonTapped(_ sender: UIButton) {
        print("Кнопка нажата!")
    }
}

private extension DishesCollectionCell {
    func addSubviews() {
        let subviews = [button, imageView, label]
        subviews.forEach {
            addSubview($0)
        }
    }

    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.Image.topOffset)
            $0.leading.equalToSuperview().offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview().offset(-Constants.horizontalOffset)
            $0.height.equalTo(Constants.Image.height)
        }

        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(Constants.Label.topOffset)
            $0.leading.equalToSuperview().offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview().offset(-Constants.horizontalOffset)
            $0.bottom.equalTo(button.snp.top).offset(-Constants.Label.bottomOffset)
        }

        button.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview().offset(-Constants.horizontalOffset)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }
}
