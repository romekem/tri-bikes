//
//  StationStatus.swift
//  TriBikes
//
//  Created by Roman on 23/04/2024.
//

import Foundation

// MARK: - StationStatusData
public struct StationsStatusData: Codable {
    let lastUpdated, ttl: Int
    let version: String
    let data: StatusData

    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case ttl, version, data
    }
}

// MARK: - DataClass
public struct StatusData: Codable {
    let stations: [StationStatus]
}

// MARK: - Station
public struct StationStatus: Codable, Hashable {
    let stationID: String
    let isInstalled, isRenting, isReturning: Bool
    let lastReported, numVehiclesAvailable, numBikesAvailable, numDocksAvailable: Int
    let vehicleTypesAvailable: [VehicleTypesAvailable]

    enum CodingKeys: String, CodingKey {
        case stationID = "station_id"
        case isInstalled = "is_installed"
        case isRenting = "is_renting"
        case isReturning = "is_returning"
        case lastReported = "last_reported"
        case numVehiclesAvailable = "num_vehicles_available"
        case numBikesAvailable = "num_bikes_available"
        case numDocksAvailable = "num_docks_available"
        case vehicleTypesAvailable = "vehicle_types_available"
    }
}

// MARK: - VehicleTypesAvailable
public struct VehicleTypesAvailable: Codable, Hashable {
    let vehicleTypeID: VehicleTypeID
    let count: Int

    enum CodingKeys: String, CodingKey {
        case vehicleTypeID = "vehicle_type_id"
        case count
    }
}

public enum VehicleTypeID: String, Codable {
    case bike = "bike"
    case ebike = "ebike"
}
