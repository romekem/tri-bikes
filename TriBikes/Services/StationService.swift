//
//  StationService.swift
//  TriBikes
//
//  Created by Roman on 23/04/2024.
//

import Foundation
import Combine

protocol StationServiceProtocol {
    func fetchStationsInfo() -> AnyPublisher<StationsInformationData,Error>
    func fetchStationsStatus() -> AnyPublisher<StationsStatusData,Error>
}

class StationService: StationServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func fetchStationsInfo() -> AnyPublisher<StationsInformationData,Error> {
        guard let url = URL(string: ApiConstants.informationUrl) else {
            return Fail(error: NetworkError.missingUrl).eraseToAnyPublisher()
        }
        return networkManager.fetchData(for: url, type: StationsInformationData.self)
    }

    func fetchStationsStatus() -> AnyPublisher<StationsStatusData, Error> {
        guard let url = URL(string: ApiConstants.statusUrl) else {
            return Fail(error: NetworkError.missingUrl).eraseToAnyPublisher()
        }
        return networkManager.fetchData(for: url, type: StationsStatusData.self)
    }
}
