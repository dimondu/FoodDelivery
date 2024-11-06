//
//  ExampleUsersService.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 06.11.2024.
//

import Foundation
import Combine

struct ExampleUsersService {

    func fetchUsers() -> AnyPublisher<[ExampleUser], Never> {

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return Just([]).eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [ExampleUser].self, decoder: JSONDecoder())
            .catch { _ in Just([]) }
            .eraseToAnyPublisher()
    }
}
