//
//  StationInformation.swift
//  TriBikes
//
//  Created by Roman on 23/04/2024.
//

import Foundation

// MARK: - StationInformation
public struct StationsInformationData: Codable {
    let lastUpdated, ttl: Int
    let version: String
    let data: InformationData

    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case ttl, version, data
    }
}

// MARK: - DataClass
public struct InformationData: Codable {
    let stations: [StationInformation]
}

// MARK: - Station
public struct StationInformation: Codable, Hashable {
    let stationID, name, address, crossStreet: String
    let lat, lon: Double
    let isVirtualStation: Bool
    let capacity: Int
    let stationArea: StationArea
    let rentalUris: RentalUris

    enum CodingKeys: String, CodingKey {
        case stationID = "station_id"
        case name, address
        case crossStreet = "cross_street"
        case lat, lon
        case isVirtualStation = "is_virtual_station"
        case capacity
        case stationArea = "station_area"
        case rentalUris = "rental_uris"
    }
}

// MARK: - RentalUris
public struct RentalUris: Codable, Hashable {
    let android, ios: String
}

// MARK: - StationArea
public struct StationArea: Codable, Hashable {
    let type: TypeEnum
    let coordinates: [[[[Double]]]]
}

enum TypeEnum: String, Codable {
    case multiPolygon = "MultiPolygon"
}
