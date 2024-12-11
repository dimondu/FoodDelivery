//
//  MainDishesViewModel.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 10.12.2024.
//

import Combine

struct MainDishesViewModel {
    let cellModels: AnyPublisher<[MainDishesCollectionCellModel], Never>
    let cancellables: [AnyCancellable]
    let isLoading: AnyPublisher<Bool, Never>
}

extension MainDishesViewModel: IViewModelType {
    typealias Coordinates = HomeCoordinator

    struct Bindings {
        let didTapCell: AnyPublisher<MainDishesCollectionCellModel, Never>
        let didTapBuyButton: AnyPublisher<MainDishesCollectionCellModel, Never>
    }

    struct Dependencies {
        let mainDishesService: IMainDishesService
        let mapper: IMainDishesMapper
    }

    static func configure(
        input: Inputs,
        binding: Bindings,
        dependency: Dependencies,
        coordinator: Coordinates
    ) -> MainDishesViewModel {
        let cellModels = CurrentValueSubject<[MainDishesCollectionCellModel], Never>([])

        let mainDishes = dependency.mainDishesService
            .loadMainDishes()
            .map { dependency.mapper.mapDishesCollectionCellModels(from: $0) }
            .sink(receiveValue: { cellModels.send($0) })

        let isLoading = cellModels
            .map(\.isEmpty)
            .eraseToAnyPublisher()

        let showDishDetail = binding.didTapCell
            .map(\.id)
            .sink { _ in
                coordinator.showDishDetail()
            }

        return .init(
            cellModels: cellModels.eraseToAnyPublisher(),
            cancellables: [mainDishes, showDishDetail],
            isLoading: isLoading
        )
    }
}
