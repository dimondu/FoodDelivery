//
//  ExampleUsersViewModel.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 06.11.2024.
//

import Foundation
import Combine

struct ExampleUsersViewModel {

    let users: AnyPublisher<[ExampleUser], Never>
    let isLoading: AnyPublisher<Bool, Never>
    let cancellables: [AnyCancellable]
}

extension ExampleUsersViewModel: IViewModelType {

    struct Inputs {}

    struct Bindings {
        let didSelectUser: AnyPublisher<ExampleUser, Never>
    }

    struct Dependencies {
        let usersService: ExampleUsersService
    }

    typealias Routes = ExampleUsersRouter

    static func configure(
        input: Inputs,
        binding: Bindings,
        dependency: Dependencies,
        router: Routes
    ) -> ExampleUsersViewModel {

        let users = CurrentValueSubject<[ExampleUser], Never>([])
        let didReceiveError = PassthroughSubject<String, Never>()

        let fetchUsers = dependency.usersService
            .fetchUsers()
            .delay(for: .seconds(3), scheduler: RunLoop.main)
            .handleEvents(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    didReceiveError.send(error.localizedDescription)
                }
            })
            .sink(receiveValue: { users.send($0) })

        let isLoading = users
            .map(\.isEmpty)
            .eraseToAnyPublisher()

        let showError = didReceiveError
            .sink(receiveValue: { error in
                router.showAlert(title: error)
            })

        let showUser = binding.didSelectUser
            .sink(receiveValue: { user in
                router.showAlert(title: user.name)
            })

        return .init(
            users: users.eraseToAnyPublisher(),
            isLoading: isLoading,
            cancellables: [fetchUsers, showError, showUser]
        )
    }
}
