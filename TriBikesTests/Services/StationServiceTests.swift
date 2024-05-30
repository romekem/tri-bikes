//
//  StationServiceTests.swift
//  TriBikesTests
//
//  Created by REDGE on 28/05/2024.
//

import XCTest
import Combine
@testable import TriBikes

final class StationServiceTests: XCTestCase {
    private var mockNetworkService: MockNetworkManager!
    private var service: StationServiceProtocol!

    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkService = MockNetworkManager()
        service = StationService(networkManager: mockNetworkService)
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testFetchStationsInfo() {
        let expectation = XCTestExpectation()
        service.fetchStationsInfo()
            .sink { _ in
            } receiveValue: { stationsData in
                XCTAssertEqual(stationsData.data.stations.count, 50)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testFetchStationsStatus() {
        let expectation = XCTestExpectation()
        service.fetchStationsStatus()
            .sink { _ in
            } receiveValue: { stationsStatus in
                XCTAssertEqual(stationsStatus.data.stations.count, 50)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
}
