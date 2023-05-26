//
//  AppDelegate.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UIViewController.init(nibName: nil, bundle: nil)
        window?.rootViewController?.view.backgroundColor = .red
        return true
    }


}

