//
//  HomeViewController.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import Combine
import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Private properties

    private let didTapCell = PassthroughSubject<HomeCategoryTableViewCellModel, Never>()
    private var cancellables = Set<AnyCancellable>()

    private var contentView = HomeView()

    // MARK: - Lifecycle

    override func loadView() {
        view = contentView
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

extension HomeViewController: IViewType {
    typealias ViewModel = HomeViewModel

    var bindings: ViewModel.Bindings {
        .init(didTapCell: didTapCell.eraseToAnyPublisher())
    }

    func bind(to viewModel: ViewModel) {
        contentView.setupBindings(
            .init(
                didTapCell: didTapCell.send,
                isLoading: viewModel.isLoading
            )
        )
    
        viewModel.cellModels
            .sink { [weak self] models in
                self?.contentView.updateDataSource(with: models)
            }
            .store(in: &cancellables)

        viewModel.cancellables
            .forEach { $0.store(in: &cancellables) }
    }
}
