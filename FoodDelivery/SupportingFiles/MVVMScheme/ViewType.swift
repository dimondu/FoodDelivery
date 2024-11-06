//
//  ViewType.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 06.11.2024.
//

/// Протокол, под который подписывается контроллер.
protocol IViewType: IHasEmptyInitialization {

    associatedtype ViewModel: IViewModelType

    /// Здесь передаем все состояния и события из контроллера в модель.
    var bindings: ViewModel.Bindings { get }

    /// Здесь происходит привязка состояний модели к экрану.
    func bind(to viewModel: ViewModel)

    static func make() -> Self
}

extension IViewType {

    static func make() -> Self {
        Self()
    }
}
