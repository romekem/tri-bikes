//
//  StationListViewModelTests.swift
//  TriBikesTests
//
//  Created by REDGE on 30/05/2024.
//

import XCTest
import Combine
import Resolver
@testable import TriBikes

final class StationListViewModelTests: XCTestCase {

    private var viewModel: StationListViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        try super.setUpWithError()
        Resolver.registerMockServices()
        viewModel = StationListViewModel()
        
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchData() {
        let expectation = XCTestExpectation(description: "fetchData")
        var bikeStations: [BikeStation] = []

        XCTAssertTrue(bikeStations.isEmpty)

        viewModel.$stations
            .dropFirst()
            .sink { stations in
                bikeStations = stations
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchData()

        wait(for: [expectation], timeout: 2)
        
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(bikeStations.count, 50)
        XCTAssertEqual(bikeStations[0].information.stationID, bikeStations[0].status.stationID)
        XCTAssertNotNil(bikeStations[0].distance)
    }
}
