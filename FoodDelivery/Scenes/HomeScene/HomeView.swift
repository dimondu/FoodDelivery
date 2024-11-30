//
//  HomeView.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import Combine
import UIKit

final class HomeView: UIView {

    private var dataSource: UITableViewDiffableDataSource<
        Int,
        CategoryTableViewCellModel
    >?
    var didTapCell: ((CategoryTableViewCellModel) -> Void)?

    private lazy var tableView = UITableView().setup {
        $0.register(CategoryTableViewCell.self)
        $0.sectionHeaderTopPadding = 0
        let tableColor = UIColor(
            red: 251 / 255,
            green: 242 / 255,
            blue: 240 / 255,
            alpha: 1
        )
        $0.backgroundColor = tableColor
        $0.delegate = self
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false

        let headerView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: $0.frame.width,
            height: 28
        ))
        headerView.backgroundColor = tableColor
        headerView.layer.cornerRadius = 16
        headerView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        $0.tableHeaderView = headerView
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupDataSource()
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<
            Int,
            CategoryTableViewCellModel
        >(
            tableView: tableView
        ) { tableView, indexPath, cellModel in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryTableViewCell.identifier,
                for: indexPath
            ) as? CategoryTableViewCell
            cell?.configure(with: cellModel)
            cell?.selectionStyle = .none
            return cell
        }
    }

    func updateDataSource(with cellModels: [CategoryTableViewCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<
            Int,
            CategoryTableViewCellModel
        >()
        snapshot.appendSections([0])
        snapshot.appendItems(cellModels, toSection: 0)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let cellModel = dataSource?.itemIdentifier(for: indexPath)
        else {
            return
        }
        didTapCell?(cellModel)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        308
    }
}
