//
//  AppDependencyContainer.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import UIKit
import SwiftUI
import PockCartData

final class ApplicationDIContainer {


    let useCaseContainer: ProductUseCaseDIContainer

    init(useCaseContainer: ProductUseCaseDIContainer) {
        self.useCaseContainer = useCaseContainer
    }

    func makeTabBarCordinator() -> TabBarCoordinator {
        let tabbarController = makeTabBarController()
        return TabBarCoordinator(tabBarController: tabbarController, factory: self)
    }

    private func makeTabBarController() -> TabBarController {
        return TabBarController()
    }

    func makeProductCoordinator() -> ProductCoordinator {
        ProductCoordinator(navigationController: UINavigationController(), factory: self)
    }

    func makeBasketCoordinator() -> BasketCoordinator {
        BasketCoordinator(navigationController: UINavigationController())
    }

    func makeProductsViewController() -> UIViewController {
        UIHostingController(rootView: makeProductsView())
    }

    private func makeProductsView() -> ProductsView {
        ProductsView(viewModel: self.makeProductsViewModel())
    }

    private func makeProductsViewModel() -> ProductViewModel {
        ProductViewModel(fetchProductsUseCase: self.useCaseContainer.makeFetchProductUseCase())
    }
}

extension ApplicationDIContainer: ApplicationCoordinatorFactory {}
extension ApplicationDIContainer: TabBarCoordinatorFactory {}
extension ApplicationDIContainer: ProductCoordinatorFactory {}
