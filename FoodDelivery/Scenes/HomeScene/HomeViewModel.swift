//
//  HomeViewModel.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 20.11.2024.
//

import Combine
import Moya

struct HomeViewModel {
    let cellModels: AnyPublisher<[HomeCategoryTableViewCellModel], Never>
    let isLoading: AnyPublisher<Bool, Never>
    let cancellables: [AnyCancellable]
}

extension HomeViewModel: IViewModelType {
    typealias Coordinates = HomeCoordinator

    struct Bindings {
        let didTapCell: AnyPublisher<HomeCategoryTableViewCellModel, Never>
    }

    struct Dependencies {
        let homeCategoriesService: IHomeCategoriesService
        let homeSceneMapper: IHomeSceneMapper
    }

    static func configure(
        input: Inputs,
        binding: Bindings,
        dependency: Dependencies,
        coordinator: Coordinates
    ) -> HomeViewModel {

        let cellModels = CurrentValueSubject<[HomeCategoryTableViewCellModel], Never>([])

        let fetchCategories = dependency.homeCategoriesService
            .fetchCategories()
            .map {
                $0.map(dependency.homeSceneMapper.map)
            }
            .sink(receiveValue: { cellModels.send($0) })

        let isLoading = cellModels
            .map(\.isEmpty)
            .eraseToAnyPublisher()

        let showDishesScene = binding.didTapCell
            .map(\.id)
            .sink { _ in
                coordinator.showDishListScene()
            }

        return .init(
            cellModels: cellModels.eraseToAnyPublisher(),
            isLoading: isLoading,
            cancellables: [fetchCategories, showDishesScene]
        )
    }
}
