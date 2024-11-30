//
//  TestHomeModels.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import Kingfisher
import SnapKit
import UIKit

struct CategoryTableViewCellModel: CellModelType, Hashable {
    let id: String
    let imageUrl: String
    let title: String
    let numberOfRatings: Int
    let rating: Double
    let priceStartsAt: Int
    let promotionalOffer: String?
}

final class CategoryTableViewCell: UITableViewCell {
    static var identifier = "CategoryTableViewCell"

    private lazy var ui = createUI()

    override func prepareForReuse() {
        super.prepareForReuse()
        ui.imageView.image = nil
        ui.titleLabel.text = nil
        ui.desriptionLabel.text = nil
        ui.promotionalOfferView.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
    }
}

extension CategoryTableViewCell: CellType {
    typealias CellModel = CategoryTableViewCellModel

    func configure(with model: CategoryTableViewCellModel) {
        ui.activityIndicator.startAnimating()
        ui.titleLabel.text = model.title
        if let url = URL(string: model.imageUrl) {
            ui.imageView.kf.setImage(with: url) { [weak self] _ in
                self?.ui.activityIndicator.stopAnimating()
            }
        }
        ui.promotionalOfferView.text = model.promotionalOffer
        let attributedDescription = createAttributedDescription(
            rating: model.rating,
            numberOfRatings: model.numberOfRatings,
            price: model.priceStartsAt
        )
        ui.desriptionLabel.attributedText = attributedDescription
    }
}

private extension CategoryTableViewCell {

    struct UI {
        let imageView: UIImageView
        let titleLabel: UILabel
        let desriptionLabel: UILabel
        let promotionalOfferView: LabelWithBackgroundView
        let activityIndicator: UIActivityIndicatorView
    }

    func createUI() -> UI {

        let imageView = UIImageView().setup {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 28
            addSubview($0)
        }

        let titleLabel = UILabel().setup {
            $0.font = UIFont(name: "Avenir-Heavy", size: 20)
            addSubview($0)
        }

        let descriptionLabel = UILabel().setup {
            $0.font = UIFont(name: "Avenir-Book", size: 16)
            addSubview($0)
        }

        let promotionalOfferView = LabelWithBackgroundView().setup {
            $0.background = UIColor(
                red: 203 / 255,
                green: 57 / 255,
                blue: 63 / 255,
                alpha: 1
            )
            $0.cornerRadius = 16
            $0.font = UIFont(name: "Avenir-Heavy", size: 18) ?? UIFont
                .systemFont(ofSize: 18)
            $0.fontColor = .white
            $0.padding = UIEdgeInsets(
                top: 10,
                left: 16,
                bottom: 10,
                right: 16
            )
            addSubview($0)
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium).setup {
            $0.color = .systemGray
            addSubview($0)
        }

        return .init(
            imageView: imageView,
            titleLabel: titleLabel,
            desriptionLabel: descriptionLabel,
            promotionalOfferView: promotionalOfferView,
            activityIndicator: activityIndicator
        )
    }

    func layoutUI() {

        backgroundColor = UIColor(
            red: 251 / 255,
            green: 242 / 255,
            blue: 240 / 255,
            alpha: 1
        )
        
        ui.activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        ui.imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.height.equalTo(210)
            make.leading.trailing.equalToSuperview().inset(28)
        }

        ui.promotionalOfferView.snp.makeConstraints { make in
            make.trailing.equalTo(ui.imageView.snp.trailing).inset(8)
            make.bottom.equalTo(ui.imageView.snp.bottom).inset(16)
            ui.promotionalOfferView.isHidden = ui.promotionalOfferView.text?
                .isEmpty ?? true
        }

        ui.titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(ui.imageView.snp.leading)
            make.trailing.equalTo(ui.imageView.snp.trailing)
            make.top.equalTo(ui.imageView.snp.bottom).offset(16)
        }

        ui.desriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(ui.titleLabel.snp.leading)
            make.trailing.equalTo(ui.titleLabel.snp.trailing)
            make.top.equalTo(ui.titleLabel.snp.bottom).offset(16)
        }
    }
}

private extension CategoryTableViewCell {
    func createAttributedDescription(
        rating: Double,
        numberOfRatings: Int,
        price: Int
    ) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        let redColor = UIColor(
            red: 232 / 255,
            green: 67 / 255,
            blue: 73 / 255,
            alpha: 1
        )
        let redColorAttributes: [NSAttributedString.Key: Any] =
            [.foregroundColor: redColor]
        let grayColor = UIColor(
            red: 96 / 255,
            green: 85 / 255,
            blue: 86 / 255,
            alpha: 1
        )
        let grayColorAttributes: [NSAttributedString.Key: Any] =
            [.foregroundColor: grayColor]

        let starRatingString = "★ \(rating)"
        let starRatingAttributedString = NSAttributedString(
            string: starRatingString,
            attributes: redColorAttributes
        )
        attributedString.append(starRatingAttributedString)

        let numberOfRatingsString = " (\(numberOfRatings) ratings) - Starts at "
        let numberOfRatingsAttributedString = NSAttributedString(
            string: numberOfRatingsString,
            attributes: grayColorAttributes
        )
        attributedString.append(numberOfRatingsAttributedString)

        let priceString = "₽\(price)"
        let priceAttributedString = NSAttributedString(
            string: priceString,
            attributes: redColorAttributes
        )
        attributedString.append(priceAttributedString)

        return attributedString
    }
}
