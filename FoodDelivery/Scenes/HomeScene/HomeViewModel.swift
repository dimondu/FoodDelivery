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
    typealias Routes = HomeRouter

    struct Bindings {
        let didTapCell: AnyPublisher<HomeCategoryTableViewCellModel, Never>
    }

    struct Dependencies {
        let categoriesService: CategoriesService
    }

    static func configure(
        input: Inputs,
        binding: Bindings,
        dependency: Dependencies,
        router: HomeRouter
    ) -> HomeViewModel {

        let cellModels = CurrentValueSubject<
            [HomeCategoryTableViewCellModel],
            Never
        >([])

        let fetchCategories = dependency.categoriesService
            .fetchCategories()
            .map {
                $0.map { HomeCategoryTableViewCellModel(
                    id: $0.id,
                    imageUrl: $0.image,
                    title: $0.title,
                    numberOfRatings: $0.ratingsCount,
                    rating: $0.stars,
                    priceStartsAt: $0.priceStartsAt,
                    promotionalOffer: $0.promotionalOffer
                )
                }
            }
            .sink(receiveValue: { cellModels.send($0) })

        let isLoading = cellModels
            .map(\.isEmpty)
            .eraseToAnyPublisher()

        let showDishesScene = binding.didTapCell
            .map(\.id)
            .sink {
                print("Тут должен быть метод роутера с переходом на подкатегорию, которая относится к категории \($0)")
            }

        return .init(
            cellModels: cellModels.eraseToAnyPublisher(),
            isLoading: isLoading,
            cancellables: [fetchCategories, showDishesScene]
        )
    }
}
