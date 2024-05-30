//
//  MockNetworkManager.swift
//  TriBikesTests
//
//  Created by Roman on 28/05/2024.
//

@testable import TriBikes
import Foundation
import Combine

class MockNetworkManager: NetworkManagerProtocol {
    func fetchData<T>(for url: URL, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable, T : Encodable {
        do {
            var mockFileName = url.lastPathComponent
            mockFileName.removeLast(".json".count)
            guard let data = try? JsonLoader.load(file: mockFileName),
                  let stationInfo = try? JSONDecoder().decode(T.self, from: data) else {
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

enum MockError: Error {
    case parsingError
}
