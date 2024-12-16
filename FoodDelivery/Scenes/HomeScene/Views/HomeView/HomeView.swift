//
//  HomeView.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import Combine
import UIKit

// MARK: - Constants

private enum Constants {
    static let mainBackgroundColor = UIColor(
        red: 251 / 255,
        green: 242 / 255,
        blue: 240 / 255,
        alpha: 1
    )
    static let secondaryBackgroundColor = UIColor(
        red: 255 / 255,
        green: 120 / 255,
        blue: 91 / 255,
        alpha: 1
    )
    static let headerViewHeight = CGFloat(56)
    static let headerViewCornerRadius = CGFloat(32)
    static let cellHeight = CGFloat(308)
    static let sideMenuButtonImageName = "line.3.horizontal"
    static let sideMenuButtonSize = CGSize(width: 32, height: 24)
    static let shoppingCartButtonSize = CGSize(width: 32, height: 32)
    static let shoppingCartButtonImageName = "black_shopping_cart_shadow"
    static let titleFont = UIFont(name: "Avenir-Heavy", size: 32)
    static let titleText = "Welcome"
    static let titleTopMargin: CGFloat = 66
    static let subtitleFont = UIFont(name: "Avenir-Light", size: 17)
    static let subtitleText = "Homemade meals prepared with love. Richest ingredients. "
    static let subtitleTopMargin: CGFloat = 24
    static let searchSize = CGSize(width: 232, height: 38)
    static let searchTopMargin: CGFloat = 20
    static let searchPlaceholder = "Search Menu"
    static let searchFont = UIFont(name: "Avenir-Light", size: 17)
    static let bigMargin: CGFloat = 56
    static let headerMargin: CGFloat = 28
    static let doubleMargin: CGFloat = 32
}

final class HomeView: IViewBindable {
    struct Bindings {
        let didTapCell: (HomeCategoryTableViewCellModel) -> Void
        let isLoading: AnyPublisher<Bool, Never>
    }

    // MARK: - Private properties

    private var dataSource: UITableViewDiffableDataSource<Int, HomeCategoryTableViewCellModel>?
    private let didTapCell = PassthroughSubject<HomeCategoryTableViewCellModel, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var isHeaderViewSet = false

    private lazy var ui = createUI()

    // MARK: - Lifecycle

    init() {
        super.init(frame: .zero)
        setupDataSource()
        setupLayoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}

    // MARK: - Internal methods

    func setupBindings(_ bindings: Bindings) {
        didTapCell
            .sink(receiveValue: bindings.didTapCell)
            .store(in: &cancellables)

        bindings.isLoading
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                return isLoading
                    ? self.ui.activityIndicator.startAnimating()
                    : self.ui.activityIndicator.stopAnimating()
            }
            .store(in: &cancellables)
    }

    func updateDataSource(with cellModels: [HomeCategoryTableViewCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeCategoryTableViewCellModel>()
        snapshot.appendSections([.zero])
        snapshot.appendItems(cellModels, toSection: .zero)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    // MARK: - Private methods

    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, HomeCategoryTableViewCellModel>(
            tableView: ui.tableView
        ) { tableView, indexPath, cellModel in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeCategoryTableViewCell.identifier,
                for: indexPath
            ) as? HomeCategoryTableViewCell
            cell?.configure(with: cellModel)
            cell?.selectionStyle = .none
            return cell
        }
    }
}

    // MARK: - UI Setup

private extension HomeView {
    // swiftlint:disable:next function_body_length
    func createUI() -> HomeViewUI {
        backgroundColor = Constants.secondaryBackgroundColor

        let sideMenuButton = UIButton().setup {
            let image = UIImage(systemName: Constants.sideMenuButtonImageName)?.withRenderingMode(.alwaysTemplate)
            $0.setBackgroundImage(image, for: .normal)
            $0.tintColor = .white
            addSubview($0)
        }

        let shoppingCartButton = UIButton().setup {
            $0.setImage(UIImage(named: Constants.shoppingCartButtonImageName), for: .normal)
            addSubview($0)
        }

        let titleLabel = UILabel().setup {
            $0.font = Constants.titleFont
            $0.text = Constants.titleText
            $0.textColor = .white
            addSubview($0)
        }

        let subtitleLabel = UILabel().setup {
            $0.font = Constants.subtitleFont
            $0.text = Constants.subtitleText
            $0.textColor = .white
            $0.numberOfLines = 0
            $0.textAlignment = .center
            addSubview($0)
        }
        let searchTextField = UISearchTextField().setup {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = Constants.searchSize.height / 2
            $0.layer.masksToBounds = true
            $0.font = Constants.searchFont
            $0.placeholder = Constants.searchPlaceholder
            $0.textColor = UIColor.darkGray
            $0.leftViewMode = .always
            if let searchIcon = $0.leftView as? UIImageView {
                searchIcon.tintColor = UIColor.darkGray // цвет иконки поиска
            }
            addSubview($0)
        }

        let tableHeaderView = UIView().setup {
            $0.backgroundColor = Constants.mainBackgroundColor
            $0.layer.cornerRadius = Constants.headerViewCornerRadius
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.layer.masksToBounds = true
            addSubview($0)
        }

        let tableView = UITableView().setup {
            $0.register(HomeCategoryTableViewCell.self)
            $0.sectionHeaderTopPadding = .zero
            $0.backgroundColor = Constants.mainBackgroundColor
            $0.delegate = self
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            addSubview($0)
        }

        let activityIndicator = UIActivityIndicatorView().setup {
            $0.style = .medium
            addSubview($0)
        }

        return .init(
            sideMenuButton: sideMenuButton,
            shoppingCartButton: shoppingCartButton,
            titleLabel: titleLabel,
            subtitleLabel: subtitleLabel,
            searchTextField: searchTextField,
            tableView: tableView,
            tableHeaderView: tableHeaderView,
            activityIndicator: activityIndicator
        )
    }

    func setupLayoutUI() {
        ui.sideMenuButton.snp.makeConstraints { make in
            make.size.equalTo(Constants.sideMenuButtonSize)
            make.top.equalToSuperview().inset(Constants.bigMargin)
            make.left.equalToSuperview().inset(Constants.doubleMargin)
        }

        ui.shoppingCartButton.snp.makeConstraints { make in
            make.size.equalTo(Constants.shoppingCartButtonSize)
            make.top.equalTo(ui.sideMenuButton.snp.top)
            make.right.equalToSuperview().inset(Constants.doubleMargin)
        }

        ui.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.titleTopMargin)
            make.centerX.equalToSuperview()
        }

        ui.subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.bigMargin)
            make.top.equalTo(ui.titleLabel.snp.bottom).offset(Constants.subtitleTopMargin)
        }

        ui.searchTextField.snp.makeConstraints { make in
            make.size.equalTo(Constants.searchSize)
            make.centerX.equalToSuperview()
            make.top.equalTo(ui.subtitleLabel.snp.bottom).offset(Constants.searchTopMargin)
        }

        ui.tableHeaderView.snp.makeConstraints { make in
            make.height.equalTo(Constants.headerViewHeight)
            make.top.equalTo(ui.searchTextField.snp.bottom).offset(Constants.doubleMargin)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(ui.tableView.snp.top).offset(Constants.headerMargin)
        }

        ui.tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }

        ui.activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - Delegates

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellModel = dataSource?.itemIdentifier(for: indexPath) else { return }
        didTapCell.send(cellModel)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}
