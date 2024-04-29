//
//  AppCoordinator.swift
//  TriBikes
//
//  Created by Roman on 28/04/2024.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let stationCoordinator = StationCoordinator(navigationController: navigationController)
        stationCoordinator.start()
        childCoordinators.append(stationCoordinator)
    }
}

