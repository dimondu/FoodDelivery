//
//  HomeViewController.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import Combine
import UIKit

final class HomeViewController: UIViewController {

    private let didTapCell = PassthroughSubject<HomeCategoryTableViewCellModel, Never>()
    private var cancellables = Set<AnyCancellable>()

    private lazy var homeView = HomeView().setup {
        $0.didTapCell = { [weak self] cellModel in
            self?.didTapCell.send(cellModel)
        }
        view.addSubview($0)
    }

    private lazy var activityIndicator = UIActivityIndicatorView().setup {
        $0.style = .medium
        view.addSubview($0)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
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

        viewModel.cellModels
            .sink { [weak self] models in
                self?.homeView.updateDataSource(with: models)
            }
            .store(in: &cancellables)

        viewModel.isLoading
            .sink { [weak self] isLoading in
                isLoading
                    ? self?.activityIndicator.startAnimating()
                    : self?.activityIndicator.stopAnimating()
            }
            .store(in: &cancellables)

        viewModel.cancellables
            .forEach { $0.store(in: &cancellables) }
    }

    func layoutUI() {
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
