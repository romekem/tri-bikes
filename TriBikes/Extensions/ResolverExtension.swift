//
//  ResolverExtension.swift
//  TriBikes
//
//  Created by Roman on 28/04/2024.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        let networkManager = NetworkManager()
        register { StationService(networkManager: networkManager) as StationServiceProtocol }
        register { LocationService() as LocationServiceProtocol }
    }
}
