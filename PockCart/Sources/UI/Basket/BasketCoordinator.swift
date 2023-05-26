//
//  BasketCoordinator.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import Foundation
import UIKit

class BasketCoordinator: Coordinatable {

    // MARK: - Properties

    let navigationController: UINavigationController

    var childCoordinators: [Coordinatable] = []
    var finished: (() -> Void)?

    // MARK: - Lifecycle

    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinatable

    func rootViewController() -> UIViewController? {
        navigationController
    }

    func start() {
        let testVC = UIViewController()
        testVC.view.backgroundColor = .green
        self.navigationController.pushViewController(testVC, animated: true)
    }
}
