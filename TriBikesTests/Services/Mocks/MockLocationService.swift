//
//  MockLocationService.swift
//  TriBikesTests
//
//  Created by Roman on 28/05/2024.
//

@testable import TriBikes
import Foundation
import Combine
import CoreLocation

class MockLocationService: LocationServiceProtocol {
    var currentLocation: Published<CLLocation?>.Publisher { $currentLocationPublished }

    @Published private var currentLocationPublished: CLLocation?
    
    func checkLocationAuthorization() {
        currentLocationPublished = CLLocation(latitude: 54.35, longitude: 18.45)
    }
}
