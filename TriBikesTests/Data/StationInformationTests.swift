//
//  StationInformationTests.swift
//  TriBikesTests
//
//  Created by REDGE on 28/05/2024.
//

import XCTest
@testable import TriBikes

final class StationInformationTests: XCTestCase {

    func testStationInformation() throws {
        let data = try JsonLoader.load(file: "station_information")
        let stationInformationData = try JSONDecoder().decode(StationsInformationData.self, from: data)

        XCTAssertEqual(stationInformationData.lastUpdated, 1716123705)
        XCTAssertEqual(stationInformationData.ttl, 15)
        XCTAssertEqual(stationInformationData.version, "2.3")

        let stationsInformation = stationInformationData.data.stations
        XCTAssertEqual(stationsInformation[0].stationID, "4971")
        XCTAssertEqual(stationsInformation[0].name, "GDA370")
        XCTAssertEqual(stationsInformation[0].address, "Lawendowe wzgórze")
        XCTAssertEqual(stationsInformation[0].crossStreet, "GDA370")
        XCTAssertEqual(stationsInformation[0].lat, 54.3272251)
        XCTAssertEqual(stationsInformation[0].lon, 18.5602068)
        XCTAssertTrue(stationsInformation[0].isVirtualStation)
        XCTAssertEqual(stationsInformation[0].capacity, 10)
        XCTAssertEqual(stationsInformation[0].stationArea.type.rawValue, "MultiPolygon")
        XCTAssertEqual(stationsInformation[0].rentalUris.ios, "rowermevo://stations/4971")
        
        let areaCoordinates = stationsInformation[0].stationArea.coordinates.flatMap { $0 }.flatMap { $0 }
        XCTAssertEqual(areaCoordinates[0], [18.559675924959038, 54.327635036160416])
    }
}
