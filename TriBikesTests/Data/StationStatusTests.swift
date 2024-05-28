//
//  StationStatusTests.swift
//  TriBikesTests
//
//  Created by REDGE on 28/05/2024.
//

import XCTest
@testable import TriBikes

final class StationStatusTests: XCTestCase {

    func testStationInformation() throws {
        let data = try JsonLoader.load(file: "station_status")
        let stationStatusData = try JSONDecoder().decode(StationsStatusData.self, from: data)

        XCTAssertEqual(stationStatusData.lastUpdated, 1716124065)
        XCTAssertEqual(stationStatusData.ttl, 15)
        XCTAssertEqual(stationStatusData.version, "2.3")

        let stationsStatus = stationStatusData.data.stations
        XCTAssertEqual(stationsStatus[0].stationID, "4971")
        XCTAssertTrue(stationsStatus[0].isInstalled)
        XCTAssertTrue(stationsStatus[0].isRenting)
        XCTAssertTrue(stationsStatus[0].isReturning)
        XCTAssertEqual(stationsStatus[0].lastReported, 1716124071)
        XCTAssertEqual(stationsStatus[0].numVehiclesAvailable, 2)
        XCTAssertEqual(stationsStatus[0].numBikesAvailable, 2)
        XCTAssertEqual(stationsStatus[0].numDocksAvailable, 8)
        XCTAssertFalse(stationsStatus[0].vehicleTypesAvailable.isEmpty)
        XCTAssertEqual(stationsStatus[0].vehicleTypesAvailable[0].vehicleTypeID.rawValue, "bike")
        XCTAssertEqual(stationsStatus[0].vehicleTypesAvailable[0].count, 0)
    }
}
