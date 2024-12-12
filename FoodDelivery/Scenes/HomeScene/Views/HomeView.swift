//
//  HomeView.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import Combine
import UIKit

private enum Constants {
    static let backgroundColor = UIColor(
        red: 251 / 255,
        green: 242 / 255,
        blue: 240 / 255,
        alpha: 1
    )
    static let headerViewHeight = CGFloat(28)
    static let headerViewCornerRadius = CGFloat(16)
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

    private lazy var tableView = UITableView().setup {
        $0.register(HomeCategoryTableViewCell.self)
        $0.sectionHeaderTopPadding = .zero
        $0.backgroundColor = Constants.backgroundColor
        $0.delegate = self
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        addSubview($0)
    }

    private lazy var headerView = UIView().setup {
        $0.backgroundColor = Constants.backgroundColor
        $0.layer.cornerRadius = Constants.headerViewCornerRadius
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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

    override func layoutSubviews() {
        super.layoutSubviews()
        setupHeaderViewIfNeeded()
    }

    // MARK: - Internal methods

    func setupBindings(_ bindings: Bindings) {
        didTapCell
            .sink(receiveValue: bindings.didTapCell)
            .store(in: &cancellables)

        bindings.isLoading
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                return isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
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
        dataSource = UITableViewDiffableDataSource<
            Int,
            HomeCategoryTableViewCellModel
        >(
            tableView: tableView
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

    private func setupLayoutUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func setupHeaderViewIfNeeded() {
        guard !isHeaderViewSet else { return }

        headerView.frame = CGRect(
            x: .zero,
            y: .zero,
            width: tableView.frame.width,
            height: Constants.headerViewHeight
        )
        tableView.tableHeaderView = headerView

        isHeaderViewSet = true
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellModel = dataSource?.itemIdentifier(for: indexPath) else { return }
        didTapCell.send(cellModel)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}
