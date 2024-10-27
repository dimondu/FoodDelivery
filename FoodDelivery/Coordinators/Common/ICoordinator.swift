//
//  ICoordinator.swift
//  FoodDelivery
//
//  Created by Александр Николаев on 27.10.2024.
//

protocol ICoordinator: AnyObject {
	func start()
}

class BaseCoordinator: ICoordinator {

	// MARK: - Internal properties
	var childCoordinators: [ICoordinator] = []

	// MARK: - Internal methods
	func start() {}

	/// Добавление зависимости (coordinator) в массив childCoordinators.
	///
	/// Добавление новой зависимости только в том случае, если такой зависимости
	/// еще нет в массиве childCoordinators.
	/// - Parameter coordinator: Зависимость, которую необходимо добавить.
	func addDependency(_ coordinator: ICoordinator) {

		guard !childCoordinators.contains(where: { $0 === coordinator }) else {
			return
		}

		childCoordinators.append(coordinator)
	}
	/// Удаление зависимости (coordinator) из массива childCoordinators у
	/// родительского координатора.
	///
	/// Код проверяет, является ли переданный координатор подтипом
	/// BaseCoordinator и имеет ли дочерние координаторы.
	/// Если условие выполняется, то происходит рекурсивный вызов
	/// removeDependency для каждого дочернего координатора,
	///  чтобы удалить все их зависимости.
	/// - Parameter coordinator: Зависимость, которую необходимо удалить.
	func removeDependency(_ coordinator: ICoordinator) {

		guard !childCoordinators.isEmpty else {
			return
		}

		if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
			coordinator.childCoordinators.forEach(removeDependency)
		}

		if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
			childCoordinators.remove(at: index)
		}
	}
}
