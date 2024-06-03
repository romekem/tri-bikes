//
//  Resolver.swift
//  TriBikesTests
//
//  Created by Roman on 31/05/2024.
//

import Foundation
import Resolver
@testable import TriBikes

extension Resolver {
    // MARK: - Mock Container
    static var mock = Resolver(child: .main)

  // MARK: - Register Mock Services
    static func registerMockServices() {
    root = Resolver.mock
    defaultScope = .application
        Resolver.mock.register { MockStationService() }.implements(StationServiceProtocol.self)
        Resolver.mock.register { MockLocationService() }.implements(LocationServiceProtocol.self)
      
    }
}

