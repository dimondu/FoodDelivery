//
//  HomeCategoryTableViewCell.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import Kingfisher
import SnapKit
import UIKit

private enum Constants {
    enum MainImageView {
        static let placeholderName = "photo"
        static let cornerRadius: CGFloat = 28
        static let margin: CGFloat = 28
        static let height: CGFloat = 210
    }

    enum PromotionView {
        static let backgroundColor = UIColor(
            red: 203 / 255,
            green: 57 / 255,
            blue: 63 / 255,
            alpha: 1
        )

        static let cornerRadius: CGFloat = 16
        static let font = UIFont(name: "Avenir-Heavy", size: 18)
        static let insets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }

    enum Margins {
        static let standart: CGFloat = 16
        static let halfStandart: CGFloat = 8
    }

    enum TextColor {
        static let red = UIColor(
            red: 232 / 255,
            green: 67 / 255,
            blue: 73 / 255,
            alpha: 1
        )
        static let gray = UIColor(
            red: 96 / 255,
            green: 85 / 255,
            blue: 86 / 255,
            alpha: 1
        )
    }

    static let identifier = "HomeCategoryTableViewCell"
    static let titleFont = UIFont(name: "Avenir-Heavy", size: 20)
    static let descriptionFont = UIFont(name: "Avenir-Book", size: 16)
}

final class HomeCategoryTableViewCell: UITableViewCell {
    static var identifier = Constants.identifier

    // MARK: - Private properties

    private lazy var ui = createUI()

    private lazy var mainImageView = UIImageView().setup {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = Constants.MainImageView.cornerRadius
        addSubview($0)
    }

    private lazy var titleLabel = UILabel().setup {
        $0.font = Constants.titleFont
        addSubview($0)
    }

    private lazy var descriptionLabel = UILabel().setup {
        $0.font = Constants.descriptionFont
        addSubview($0)
    }

    private lazy var promotionView = LabelWithBackgroundView().setup {
        $0.background = Constants.PromotionView.backgroundColor
        $0.cornerRadius = Constants.PromotionView.cornerRadius
        $0.font = Constants.PromotionView.font
        $0.fontColor = .white
        $0.padding = Constants.PromotionView.insets
        addSubview($0)
    }

    private lazy var activityIndicator = UIActivityIndicatorView(style: .medium).setup {
        $0.color = .systemGray
        addSubview($0)
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        ui.mainImageView.image = nil
        ui.titleLabel.text = nil
        ui.desriptionLabel.text = nil
        ui.promotionView.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayoutUI()
    }
}

extension HomeCategoryTableViewCell: ICell {
    typealias CellModel = HomeCategoryTableViewCellModel

    func configure(with model: CellModel) {
        ui.titleLabel.text = model.title
        ui.mainImageView.setImage(
            with: model.imageUrl,
            placeholder: UIImage(systemName: Constants.MainImageView.placeholderName),
            acivityIndacator: ui.activityIndicator
        )
        ui.promotionView.text = model.promotionalOffer
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
        .init(
            mainImageView: mainImageView,
            titleLabel: titleLabel,
            desriptionLabel: descriptionLabel,
            promotionView: promotionView,
            activityIndicator: activityIndicator
        )
    }

    func setupLayoutUI() {
        backgroundColor = .clear

        ui.activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        ui.mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Margins.standart)
            make.height.equalTo(Constants.MainImageView.height)
            make.leading.trailing.equalToSuperview().inset(Constants.MainImageView.margin)
        }

        ui.promotionView.snp.makeConstraints { make in
            make.trailing.equalTo(ui.mainImageView.snp.trailing).inset(Constants.Margins.halfStandart)
            make.bottom.equalTo(ui.mainImageView.snp.bottom).inset(Constants.Margins.standart)
            ui.promotionView.isHidden = ui.promotionView.text?
                .isEmpty ?? true
        }

        ui.titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(ui.mainImageView.snp.leading)
            make.trailing.equalTo(ui.mainImageView.snp.trailing)
            make.top.equalTo(ui.mainImageView.snp.bottom).offset(Constants.Margins.halfStandart)
        }

        ui.desriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(ui.titleLabel.snp.leading)
            make.trailing.equalTo(ui.titleLabel.snp.trailing)
            make.top.equalTo(ui.titleLabel.snp.bottom)
        }
    }
}

private extension HomeCategoryTableViewCell {
    func createAttributedDescription(
        rating: Double,
        numberOfRatings: Int,
        price: Int
    ) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        let redColorAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: Constants.TextColor.red]
        let grayColorAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: Constants.TextColor.gray]

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
