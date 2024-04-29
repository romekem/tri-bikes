//
//  StationListViewModel.swift
//  TriBikes
//
//  Created by Roman on 23/04/2024.
//

import Combine
import Resolver
import CoreLocation

final class StationListViewModel {
    @Published var stations: [BikeStation] = []
    @Published var error: Error?

    @Injected private var stationService: StationServiceProtocol
    @Injected private var locationService: LocationServiceProtocol

    private var cancellables = Set<AnyCancellable>()

    init() {
        bind()
    }

    func fetchData() {
        let infoPublisher = stationService.fetchStationsInfo()
        let statusPublisher = stationService.fetchStationsStatus()

        Publishers.Zip(infoPublisher, statusPublisher)
            .sink { [weak self] completion in
                switch completion {
                case .finished: 
                    break
                case let .failure(error):
                    self?.error = error
                }
            } receiveValue: { [weak self] infoData, statusData in
                let infoStations = infoData.data.stations
                let stationsStatus = statusData.data.stations
                
                self?.stations = infoStations.compactMap { info in
                    guard let status = stationsStatus.first(where: { $0.stationID == info.stationID }) else { return nil }
                    return BikeStation(information: info, status: status)
                }
            }
            .store(in: &cancellables)

    }

    func requestUserLocation() {
        locationService.checkLocationAuthorization()
    }

    func bind() {
        locationService.currentLocation
            .sink(receiveValue: { [weak self] location in
                guard let self,
                      let location else { return }
                let newStations = self.stations
                    .map { self.calculateDistance(forStation: $0, location: location) }
                    .sorted { $0.distance ?? 0 < $1.distance ?? 0 }

                self.stations = newStations
            })
            .store(in: &cancellables)
    }

    private func calculateDistance(forStation station: BikeStation, location: CLLocation) -> BikeStation {
        let stationLocation = CLLocation(latitude: station.information.lat, longitude: station.information.lon)
        let distance = stationLocation.distance(from: location)
        var bikeStation = station
        bikeStation.distance = Int(distance)

        return bikeStation
    }
}
