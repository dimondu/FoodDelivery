//
//  HomeView.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import Combine
import UIKit

final class HomeView: UIView {
    private var dataSource: UITableViewDiffableDataSource<Int, HomeCategoryTableViewCellModel>?
    var didTapCell: ((HomeCategoryTableViewCellModel) -> Void)?

    private lazy var tableView = UITableView().setup {
        $0.register(HomeCategoryTableViewCell.self)
        $0.sectionHeaderTopPadding = .zero
        $0.backgroundColor = Constants.backgroundColor
        $0.delegate = self
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false

        let headerView = UIView(frame: CGRect(
            x: .zero,
            y: .zero,
            width: $0.frame.width,
            height: Constants.headerViewHeight
        ))
        headerView.backgroundColor = Constants.backgroundColor
        headerView.layer.cornerRadius = Constants.headerViewCornerRadius
        headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.tableHeaderView = headerView
        addSubview($0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupDataSource()
        setupLayoutUI()
    }

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

    func updateDataSource(with cellModels: [HomeCategoryTableViewCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeCategoryTableViewCellModel>()
        snapshot.appendSections([.zero])
        snapshot.appendItems(cellModels, toSection: .zero)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func setupLayoutUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

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
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellModel = dataSource?.itemIdentifier(for: indexPath) else { return }
        didTapCell?(cellModel)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}
