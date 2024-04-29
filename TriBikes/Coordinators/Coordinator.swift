//
//  Coordinator.swift
//  TriBikes
//
//  Created by Roman on 28/04/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
