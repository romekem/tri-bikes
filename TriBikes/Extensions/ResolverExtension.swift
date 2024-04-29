//
//  ResolverExtension.swift
//  TriBikes
//
//  Created by Roman on 28/04/2024.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { StationService() as StationServiceProtocol }
        register { LocationService() as LocationServiceProtocol }
    }
}
