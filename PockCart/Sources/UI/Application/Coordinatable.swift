//
//  Coordinatable.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import UIKit

protocol Coordinatable: AnyObject {
    var childCoordinators: [Coordinatable] { get set }
    func push(childCoordinator: Coordinatable)
    func popChildCoordinator()
    func rootViewController() -> UIViewController?
    func lastCoordinator() -> Coordinatable
    func start()
    var finished: (() -> Void)? { get set }
}

// MARK: Default Implementation

extension Coordinatable {
    func push(childCoordinator coordinator: Coordinatable) {
        childCoordinators.append(coordinator)
    }

    func popChildCoordinator() {
        _ = childCoordinators.popLast()
    }

    func popChildCoordinator(coordinator: Coordinatable) {
        if let index = childCoordinators
            .enumerated()
            .filter({ $0.element === coordinator })
            .map({ $0.offset })
            .first
        {
            childCoordinators.remove(at: index)
        }
    }

    func lastCoordinator() -> Coordinatable {
        var last: Coordinatable = self
        if let lastChildCoordinator = childCoordinators.last {
            last = lastChildCoordinator.lastCoordinator()
        }
        return last
    }
}

