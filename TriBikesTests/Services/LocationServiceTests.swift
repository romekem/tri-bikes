//
//  LocationServiceTests.swift
//  TriBikesTests
//
//  Created by Roman on 30/05/2024.
//

import XCTest
import Combine
@testable import TriBikes

final class LocationServiceTests: XCTestCase {
    private var service: LocationServiceProtocol!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        service = MockLocationService()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func testCurrentLocation() {
        let expectation = XCTestExpectation()
        
        service.currentLocation.sink { location in
            XCTAssertNil(location)
            expectation.fulfill()
        }
        .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
