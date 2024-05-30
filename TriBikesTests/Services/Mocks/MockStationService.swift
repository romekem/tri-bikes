//
//  MockStationService.swift
//  TriBikesTests
//
//  Created by Roman on 28/05/2024.
//

@testable import TriBikes
import Foundation
import Combine

class MockStationService: StationServiceProtocol {
    func fetchStationsInfo() -> AnyPublisher<StationsInformationData, any Error> {
        do {
            guard let data = try? JsonLoader.load(file: "station_information"),
                  let stationInfo = try? JSONDecoder().decode(StationsInformationData.self, from: data) else {
                throw MockError.parsingError
            }
            return Just(stationInfo)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    func fetchStationsStatus() -> AnyPublisher<StationsStatusData, any Error> {
        do {
            guard let data = try? JsonLoader.load(file: "station_status"),
                  let stationInfo = try? JSONDecoder().decode(StationsStatusData.self, from: data) else {
                throw MockError.parsingError
            }
            return Just(stationInfo)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
