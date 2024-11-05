//
//  MVVMWithCombineExample.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 05.11.2024.
//

import Combine
import Foundation
import UIKit

struct ExampleUser: Codable {
    let name: String
    let email: String
}

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

struct ExampleUsersScreenBuilder: ScreenBuilder {

    typealias ViewController = ExampleUsersViewController

    var dependencies: ViewController.ViewModel.Dependencies {
        .init(
            usersService: ExampleUsersService()
        )
    }
}

final class ExampleUsersViewController: UIViewController {

    private let users = CurrentValueSubject<[ExampleUser], Never>([])
    private let didSelectUser = PassthroughSubject<ExampleUser, Never>()

    private var cancellables = Set<AnyCancellable>()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellID)
        view.addSubview(tableView)
        return tableView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = UIActivityIndicatorView.Style.medium
        view.addSubview(indicator)
        return indicator
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
        activityIndicator.center = view.center
    }
}

extension ExampleUsersViewController: ViewType {

    typealias ViewModel = ExampleUsersViewModel

    var bindings: ExampleUsersViewModel.Bindings {
        .init(
            didSelectUser: didSelectUser.eraseToAnyPublisher()
        )
    }

    func bind(to viewModel: ExampleUsersViewModel) {

        viewModel.users
            .sink(receiveValue: { [weak self] users in
                self?.users.send(users)
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)

        viewModel.isLoading
            .sink { [weak self] isLoading in
                isLoading ? self?.activityIndicator.startAnimating() : self?
                    .activityIndicator.stopAnimating()
            }
            .store(in: &cancellables)

        viewModel.cancellables
            .forEach { $0.store(in: &cancellables) }
    }
}

extension ExampleUsersViewController: UITableViewDataSource,
UITableViewDelegate {

    private static let cellID = "cellID"

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        users.value.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellID)
        let user = users.value[indexPath.row]
        cell?.textLabel?.text = user.name
        cell?.detailTextLabel?.text = user.email
        cell?.selectionStyle = .none
        return cell ?? .init()
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let user = users.value[indexPath.row]
        didSelectUser.send(user)
    }
}

struct ExampleUsersViewModel {

    let users: AnyPublisher<[ExampleUser], Never>
    let isLoading: AnyPublisher<Bool, Never>
    let cancellables: [AnyCancellable]
}

extension ExampleUsersViewModel: ViewModelType {

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

struct ExampleUsersRouter: RouterType {

    let viewController: UIViewController

    init(transitionHandler: UIViewController) {
        viewController = transitionHandler
    }

    func showAlert(title: String) {

        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )

        alertController.addAction(.init(title: "OK", style: .default))

        viewController.present(alertController, animated: true)
    }
}
