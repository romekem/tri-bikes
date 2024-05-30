//
//  NetworkManager.swift
//  TriBikes
//
//  Created by Roman on 28/05/2024.
//

import Foundation
import Combine

public protocol NetworkManagerProtocol {
    func fetchData<T: Codable>(for url: URL, type: T.Type) -> AnyPublisher<T, Error>
}

class NetworkManager: NetworkManagerProtocol {
    private let urlSession = URLSession(configuration: .default)
    private let jsonDecoder = JSONDecoder()
    
    func fetchData<T: Codable>(for url: URL, type: T.Type) -> AnyPublisher<T, Error> {
        urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
