//
//  DishesViewModel.swift
//  FoodDelivery
//
//  Created by Дмитрий Дуров on 10.12.2024.
//

import Combine

struct DishesViewModel {
    let cellModels: AnyPublisher<[DishesCollectionCellModel], Never>
    let cancellables: [AnyCancellable]
    let isLoading: AnyPublisher<Bool, Never>
}

extension DishesViewModel: IViewModelType {
    typealias Coordinates = HomeCoordinator

    struct Bindings {
        let didTapCell: AnyPublisher<DishesCollectionCellModel, Never>
        let didTapBuyButton: AnyPublisher<DishesCollectionCellModel, Never>
    }

    struct Dependencies {
        let dishesService: IDishesService
        let mapper: IDishesMapper
    }

    static func configure(
        input: Inputs,
        binding: Bindings,
        dependency: Dependencies,
        coordinator: Coordinates
    ) -> DishesViewModel {
        let cellModels = CurrentValueSubject<[DishesCollectionCellModel], Never>([])

        let dishes = dependency.dishesService
            .loadDishes()
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
            cancellables: [dishes, showDishDetail],
            isLoading: isLoading
        )
    }
}
