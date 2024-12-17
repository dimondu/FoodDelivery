//
//  DishesViewController.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 05.12.2024.
//

import Combine
import UIKit

// MARK: - DishesViewController

final class DishesViewController: UIViewController {
    // MARK: - Properties

    private let didTapBuyButton = PassthroughSubject<DishesCollectionCellModel, Never>()
    private let didTapCell = PassthroughSubject<DishesCollectionCellModel, Never>()
    private var cancellables = Set<AnyCancellable>()

    private lazy var contentView: DishesView = {
        let view = DishesView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    // MARK: - Overriden methods

    override func loadView() {
        view = contentView
    }
}

extension DishesViewController: IViewType {
    typealias ViewModel = DishesViewModel

    var bindings: ViewModel.Bindings {
        .init(
            didTapCell: didTapCell.eraseToAnyPublisher(),
            didTapBuyButton: didTapBuyButton.eraseToAnyPublisher()
        )
    }

    func bind(to viewModel: ViewModel) {
    // TODO: Доделать
    }
}

extension DishesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2 // TODO: будет правиться
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1 // TODO: будет правиться
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: будет правиться
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishesCollectionCell.identifier, for: indexPath)
        return cell
    }
}

extension DishesViewController: UICollectionViewDelegate {
    // TODO: будет правиться
}
