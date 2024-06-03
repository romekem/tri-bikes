//
//  LocationService.swift
//  TriBikes
//
//  Created by Roman on 28/04/2024.
//

import CoreLocation

protocol LocationServiceProtocol {
    var currentLocation: Published<CLLocation?>.Publisher { get }

    func checkLocationAuthorization()
}

class LocationService: NSObject, LocationServiceProtocol {
    var currentLocation: Published<CLLocation?>.Publisher { $currentLocationPublished }
    
    private var locationManager: CLLocationManager?

    @Published private var currentLocationPublished: CLLocation?

    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    func checkLocationAuthorization() {
        guard let locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location is restricted.")
        case .denied:
            print("Location is denied.")
        case .authorizedAlways, .authorizedWhenInUse:
            currentLocationPublished = locationManager.location
        default:
            break
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
