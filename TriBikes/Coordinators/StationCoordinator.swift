//
//  StationCoordinator.swift
//  TriBikes
//
//  Created by Roman on 28/04/2024.
//

import Foundation

import UIKit

final class StationCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators = []
    }
    
    func start() {
        let viewModel = StationListViewModel()
        let viewController = StationListViewController(viewModel: viewModel)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }

    private func startDetails(station: BikeStation) {
        let viewModel = StationDetailsViewModel(station: station)
        let viewController = StationDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showAErrorlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel))
        navigationController.topViewController?.present(alert, animated: true)
    }
}

extension StationCoordinator: StationListViewControllerDelegate {
    func didReceiveError(_ error: any Error) {
        showAErrorlert(error: error)
    }
    
    func didSelectStation(_ station: BikeStation) {
        startDetails(station: station)
    }
}
