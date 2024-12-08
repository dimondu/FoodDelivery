//
//  MainDishesCollectionCell.swift
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
    static let identifier = "MainDishesCollectionCell"
    static let horizontalOffset: CGFloat = 16
}

// MARK: - MainDishesCollectionCell

final class MainDishesCollectionCell: UICollectionViewCell {
    // MARK: - Properties

    static let identifier = Constants.identifier

    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.Button.fontSize)
        button.backgroundColor = Constants.Button.backgroundColor
        button.layer.cornerRadius = Constants.Button.cornerRadius
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
        label.font = .systemFont(ofSize: Constants.Label.fontSize)
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

private extension MainDishesCollectionCell {
    func addSubviews() {
        let subviews = [button, imageView, label]
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
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
