//
//  MainDishesViewController.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 05.12.2024.
//

import Combine
import UIKit

// MARK: - MainDishesViewController

final class MainDishesViewController: UIViewController {
    // MARK: - Properties

    private let didTapBuyButton = PassthroughSubject<MainDishesCollectionCellModel, Never>()
    private let didTapCell = PassthroughSubject<MainDishesCollectionCellModel, Never>()
    private var cancellables = Set<AnyCancellable>()

    private lazy var contentView: MainDishesView = {
        let view = MainDishesView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    // MARK: - Overriden methods

    override func loadView() {
        view = contentView
    }
}

extension MainDishesViewController: IViewType {
    typealias ViewModel = MainDishesViewModel

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

extension MainDishesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2 // TODO: будет правиться
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1 // TODO: будет правиться
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: будет правиться
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainDishesCollectionCell.identifier, for: indexPath)
        return cell
    }
}

extension MainDishesViewController: UICollectionViewDelegate {
    // TODO: будет правиться
}
