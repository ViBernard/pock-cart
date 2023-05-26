//
//  AppDelegate.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import UIKit
import PockCartData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appCoordinator: Coordinatable?
    var applicationDIContainer: ApplicationDIContainer?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let diContainer = ApplicationDIContainer(useCaseContainer: ProductUseCaseDIContainer())
        self.applicationDIContainer = diContainer
        appCoordinator = ApplicationCoordinator(factory: diContainer)
        appCoordinator?.start()
        return true
    }
}

