//
//  ExampleUsersScreenBuilder.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 06.11.2024.
//

struct ExampleUsersScreenBuilder: IScreenBuilder {

    typealias ViewController = ExampleUsersViewController

    var dependencies: ViewController.ViewModel.Dependencies {
        .init(
            usersService: ExampleUsersService()
        )
    }
}
