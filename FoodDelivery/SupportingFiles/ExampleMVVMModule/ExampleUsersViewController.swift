//
//  ExampleUsersViewController.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 06.11.2024.
//

import Combine
import UIKit

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

extension ExampleUsersViewController: IViewType {

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
