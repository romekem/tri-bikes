//
//  AppDelegate.swift
//  TriBikes
//
//  Created by Roman on 23/04/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        setupNavigationBar(navigation: navigationController)
        
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

    private func setupNavigationBar(navigation: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .primarytNavy
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigation.navigationBar.tintColor = .white
        navigation.navigationBar.standardAppearance = appearance
        navigation.navigationBar.compactAppearance = appearance
        navigation.navigationBar.scrollEdgeAppearance = appearance
    }
}

