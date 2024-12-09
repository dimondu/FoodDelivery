//
//  MainDishesView.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 04.12.2024.
//

import SnapKit
import UIKit

// MARK: - Constants

private enum Constants {
    static let minimumInteritemSpacing: CGFloat = 30
    static let minimumLineSpacing: CGFloat = 15
}

// MARK: - MainDishesView

final class MainDishesView: UIView {
    // MARK: - Properties

    weak var dataSource: UICollectionViewDataSource?
    weak var delegate: UICollectionViewDelegate?

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            MainDishesCollectionCell.self,
            forCellWithReuseIdentifier: MainDishesCollectionCell.identifier
        )
        return collectionView
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

private extension MainDishesView {
    func addSubviews() {
        let subviews = [collectionView]
        subviews.forEach {
            addSubview($0)
        }
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        layout.minimumLineSpacing = Constants.minimumLineSpacing

        return layout
    }
}
