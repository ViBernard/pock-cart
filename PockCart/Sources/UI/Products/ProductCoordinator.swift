//
//  ProductCoordinator.swift
//  PockCart
//
//  Created by vivien bernard on 26/05/2023.
//

import UIKit

class ProductCoordinator: Coordinatable {

    let factory: ProductCoordinatorFactory

    let navigationController: UINavigationController

    var childCoordinators: [Coordinatable] = []
    var finished: (() -> Void)?

    init(navigationController:UINavigationController, factory: ProductCoordinatorFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func rootViewController() -> UIViewController? {
        navigationController
    }

    func start() {
        let testVC = factory.makeProductsViewController()
        testVC.view.backgroundColor = .white
        self.navigationController.pushViewController(testVC, animated: true)
    }

}

protocol ProductCoordinatorFactory {
    func makeProductsViewController() -> UIViewController
}
