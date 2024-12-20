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
    enum Colors {
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
    }

    enum Header {
        static let height: CGFloat = 56
        static let cornerRadius: CGFloat = 32
        static let margin: CGFloat = 28
    }

    enum SideMenuButton {
        static let imageName = "line.3.horizontal"
        static let size = CGSize(width: 32, height: 24)
    }

    enum ShopppingCartButton {
        static let imageName = "black_shopping_cart_shadow"
        static let size = CGSize(width: 32, height: 32)
    }

    enum TitleLabel {
        static let font = UIFont(name: "Avenir-Heavy", size: 32)
        static let text = "Welcome"
        static let margin: CGFloat = 66
    }

    enum SubTitleLabel {
        static let font = UIFont(name: "Avenir-Light", size: 17)
        static let text = "Homemade meals prepared with love. Richest ingredients. "
        static let margin: CGFloat = 24
    }

    enum SearchField {
        static let size = CGSize(width: 232, height: 38)
        static let cornerRadius: CGFloat = size.height / 2
        static let margin: CGFloat = 20
        static let placeholder = "Search Menu"
        static let font = UIFont(name: "Avenir-Light", size: 17)
    }

    enum Margins {
        static let bigMargin: CGFloat = 56
        static let doubleStandart: CGFloat = 32
    }

    static let cellHeight = CGFloat(308)
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

    private lazy var sideMenuButton = UIButton().setup {
        let image = UIImage(systemName: Constants.SideMenuButton.imageName)?.withRenderingMode(.alwaysTemplate)
        $0.setBackgroundImage(image, for: .normal)
        $0.tintColor = .white
        addSubview($0)
    }

    private lazy var shoppingCartButton = UIButton().setup {
        $0.setImage(UIImage(named: Constants.ShopppingCartButton.imageName), for: .normal)
        addSubview($0)
    }

    private lazy var titleLabel = UILabel().setup {
        $0.font = Constants.TitleLabel.font
        $0.text = Constants.TitleLabel.text
        $0.textColor = .white
        addSubview($0)
    }

    private lazy var subtitleLabel = UILabel().setup {
        $0.font = Constants.SubTitleLabel.font
        $0.text = Constants.SubTitleLabel.text
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.textAlignment = .center
        addSubview($0)
    }

    private lazy var searchTextField = UISearchTextField().setup {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = Constants.SearchField.cornerRadius
        $0.layer.masksToBounds = true
        $0.font = Constants.SearchField.font
        $0.placeholder = Constants.SearchField.placeholder
        $0.textColor = UIColor.darkGray
        $0.leftViewMode = .always
        if let searchIcon = $0.leftView as? UIImageView {
            searchIcon.tintColor = UIColor.darkGray // цвет иконки поиска
        }
        addSubview($0)
    }

    private lazy var tableHeaderView = UIView().setup {
        $0.backgroundColor = Constants.Colors.mainBackgroundColor
        $0.layer.cornerRadius = Constants.Header.cornerRadius
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.masksToBounds = true
        addSubview($0)
    }

    private lazy var tableView = UITableView().setup {
        $0.register(HomeCategoryTableViewCell.self)
        $0.sectionHeaderTopPadding = .zero
        $0.backgroundColor = Constants.Colors.mainBackgroundColor
        $0.delegate = self
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        addSubview($0)
    }

    private lazy var activityIndicator = UIActivityIndicatorView().setup {
        $0.style = .medium
        addSubview($0)
    }

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
    func createUI() -> HomeViewUI {
        backgroundColor = Constants.Colors.secondaryBackgroundColor

        return .init(
            sideMenuButton: sideMenuButton,
            shoppingCartButton: shoppingCartButton,
            titleLabel: titleLabel,
            subtitleLabel: subtitleLabel,
            searchTextField: searchTextField,
            tableHeaderView: tableHeaderView,
            tableView: tableView,
            activityIndicator: activityIndicator
        )
    }

    func setupLayoutUI() {
        ui.sideMenuButton.snp.makeConstraints { make in
            make.size.equalTo(Constants.SideMenuButton.size)
            make.top.equalToSuperview().inset(Constants.Margins.bigMargin)
            make.left.equalToSuperview().inset(Constants.Margins.doubleStandart)
        }

        ui.shoppingCartButton.snp.makeConstraints { make in
            make.size.equalTo(Constants.ShopppingCartButton.size)
            make.top.equalTo(ui.sideMenuButton.snp.top)
            make.right.equalToSuperview().inset(Constants.Margins.doubleStandart)
        }

        ui.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.TitleLabel.margin)
            make.centerX.equalToSuperview()
        }

        ui.subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Margins.bigMargin)
            make.top.equalTo(ui.titleLabel.snp.bottom).offset(Constants.SubTitleLabel.margin)
        }

        ui.searchTextField.snp.makeConstraints { make in
            make.size.equalTo(Constants.SearchField.size)
            make.centerX.equalToSuperview()
            make.top.equalTo(ui.subtitleLabel.snp.bottom).offset(Constants.SearchField.margin)
        }

        ui.tableHeaderView.snp.makeConstraints { make in
            make.height.equalTo(Constants.Header.height)
            make.top.equalTo(ui.searchTextField.snp.bottom).offset(Constants.Margins.doubleStandart)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(ui.tableView.snp.top).offset(Constants.Header.margin)
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
