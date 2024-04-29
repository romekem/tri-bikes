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
    private let urlSession = URLSession.shared
    private let jsonDecoder = JSONDecoder()

    func fetchStationsInfo() -> AnyPublisher<StationsInformationData,Error> {
        guard let url = URL(string: ApiConstants.informationUrl) else {
            return Fail(error: NetworkError.missingUrl).eraseToAnyPublisher()
        }
        return urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: StationsInformationData.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }

    func fetchStationsStatus() -> AnyPublisher<StationsStatusData, Error> {
        guard let url = URL(string: ApiConstants.statusUrl) else {
            return Fail(error: NetworkError.missingUrl).eraseToAnyPublisher()
        }
        return urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: StationsStatusData.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
