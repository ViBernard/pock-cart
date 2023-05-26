//
//  TabbarCoordinator.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import Foundation
import UIKit

final class TabBarCoordinator: Coordinatable {

    // MARK: Properties
    let factory:TabBarCoordinatorFactory

    let tabBarController: TabBarController
    var childCoordinators: [Coordinatable] = []

    // MARK: Lifecycle

    init(tabBarController: TabBarController, factory: TabBarCoordinatorFactory) {
        self.tabBarController = tabBarController
        self.factory = factory
    }

    // MARK: Coordinatable

    func rootViewController() -> UIViewController? {
        tabBarController
    }

    func start() {

        let productCoordinator = factory.makeProductCoordinator()//ProductCoordinator(navigationController: UINavigationController())
        productCoordinator.start()


        let homeController = productCoordinator.navigationController
        homeController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(), selectedImage: nil)
               childCoordinators.append(productCoordinator)

        let basketCoordinator = factory.makeBasketCoordinator()//BasketCoordinator(navigationController: UINavigationController())


        let basketController = basketCoordinator.navigationController
        basketController.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(), selectedImage: nil)
               childCoordinators.append(basketCoordinator)

        tabBarController.setViewControllers([homeController, basketController], animated: true)
        
            //    tabBarController.tabBar.isTranslucent = true



    }

    var finished: (() -> Void)?

    // MARK: Methods


}

protocol TabBarCoordinatorFactory {
    func makeProductCoordinator() -> ProductCoordinator
    func makeBasketCoordinator() -> BasketCoordinator
}
