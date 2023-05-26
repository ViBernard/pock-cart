//
//  AppCoordinator.swift
//  PockCart
//
//  Created by vivien bernard on 26/05/2023.
//

import UIKit

final class ApplicationCoordinator: Coordinatable {

    // MARK: - Properties

    var window: UIWindow?
    var childCoordinators: [Coordinatable] = []

    let applicationCoordinatorFactory: ApplicationCoordinatorFactory

    // MARK: - Lifecycle

    init(factory: ApplicationCoordinatorFactory) {
        self.applicationCoordinatorFactory = factory
    }

    // MARK: - Coordinatable

    func rootViewController() -> UIViewController? {
        window?.rootViewController
    }

    func start() {
        let coordinator = buildTabBarCoordinator()
        buildWindow(viewController: coordinator.rootViewController())
    }

    var finished: (() -> Void)?

    // MARK: - Methods

    func buildTabBarCoordinator() -> TabBarCoordinator {
        let tabCoordinator = applicationCoordinatorFactory.makeTabBarCordinator()
        tabCoordinator.start()
        self.push(childCoordinator: tabCoordinator)
        tabCoordinator.finished = { [weak self] in
            self?.popChildCoordinator(coordinator: tabCoordinator)
        }
        return tabCoordinator
    }

    func buildWindow(viewController: UIViewController?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = viewController
    }

}

protocol ApplicationCoordinatorFactory {
    func makeTabBarCordinator()-> TabBarCoordinator
}
