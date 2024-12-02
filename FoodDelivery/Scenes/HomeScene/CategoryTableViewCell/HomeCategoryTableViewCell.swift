//
//  HomeCategoryTableViewCell.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import Kingfisher
import SnapKit
import UIKit

final class HomeCategoryTableViewCell: UITableViewCell {
    static var identifier = Constants.identifier

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

extension HomeCategoryTableViewCell: ICellType {
    typealias CellModel = HomeCategoryTableViewCellModel

    func configure(with model: CellModel) {
        ui.activityIndicator.startAnimating()
        ui.titleLabel.text = model.title
        if let url = URL(string: model.imageUrl) {
            ui.imageView.kf.setImage(with: url) { [weak self] _ in
                self?.ui.activityIndicator.stopAnimating()
            }
        }
        ui.activityIndicator.stopAnimating()
        ui.promotionalOfferView.text = model.promotionalOffer
        let attributedDescription = createAttributedDescription(
            rating: model.rating,
            numberOfRatings: model.numberOfRatings,
            price: model.priceStartsAt
        )
        ui.desriptionLabel.attributedText = attributedDescription
    }
}

private extension HomeCategoryTableViewCell {

    func createUI() -> HomeCategoryTableViewCellUI {

        let imageView = UIImageView().setup {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = Constants.imageViewCornerRadius
            addSubview($0)
        }

        let titleLabel = UILabel().setup {
            $0.font = Constants.titleFont
            addSubview($0)
        }

        let descriptionLabel = UILabel().setup {
            $0.font = Constants.descriptionFont
            addSubview($0)
        }

        let promotionalOfferView = LabelWithBackgroundView().setup {
            $0.background = Constants.offerBackground
            $0.cornerRadius = Constants.offerCornerRadius
            $0.font = Constants.offerFont
            $0.fontColor = .white
            $0.padding = Constants.offerInsets
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

        backgroundColor = .clear

        ui.activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        ui.imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.margin)
            make.height.equalTo(Constants.imageHeight)
            make.leading.trailing.equalToSuperview().inset(Constants.imageMargin)
        }

        ui.promotionalOfferView.snp.makeConstraints { make in
            make.trailing.equalTo(ui.imageView.snp.trailing).inset(Constants.halMargin)
            make.bottom.equalTo(ui.imageView.snp.bottom).inset(Constants.margin)
            ui.promotionalOfferView.isHidden = ui.promotionalOfferView.text?
                .isEmpty ?? true
        }

        ui.titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(ui.imageView.snp.leading)
            make.trailing.equalTo(ui.imageView.snp.trailing)
            make.top.equalTo(ui.imageView.snp.bottom).offset(Constants.margin)
        }

        ui.desriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(ui.titleLabel.snp.leading)
            make.trailing.equalTo(ui.titleLabel.snp.trailing)
            make.top.equalTo(ui.titleLabel.snp.bottom).offset(Constants.margin)
        }
    }

    enum Constants {
        static let identifier = "HomeCategoryTableViewCell"
        static let imageViewCornerRadius = CGFloat(28)
        static let titleFont = UIFont(name: "Avenir-Heavy", size: 20)
        static let descriptionFont = UIFont(name: "Avenir-Book", size: 16)
        static let offerBackground = UIColor(
            red: 203 / 255,
            green: 57 / 255,
            blue: 63 / 255,
            alpha: 1
        )
        static let offerCornerRadius = CGFloat(16)
        static let offerFont = UIFont(name: "Avenir-Heavy", size: 18)
        static let offerInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        static let redTextColor = UIColor(
            red: 232 / 255,
            green: 67 / 255,
            blue: 73 / 255,
            alpha: 1
        )
        static let grayTextColor = UIColor(
            red: 96 / 255,
            green: 85 / 255,
            blue: 86 / 255,
            alpha: 1
        )
        static let margin = CGFloat(16)
        static let halMargin = CGFloat(8)
        static let imageMargin = CGFloat(28)
        static let imageHeight = CGFloat(210)
        
    }
}

private extension HomeCategoryTableViewCell {
    func createAttributedDescription(
        rating: Double,
        numberOfRatings: Int,
        price: Int
    ) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        let redColorAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: Constants.redTextColor]
        let grayColorAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: Constants.grayTextColor]

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
