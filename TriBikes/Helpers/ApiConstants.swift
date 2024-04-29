//
//  ApiConstatnst.swift
//  TriBikes
//
//  Created by Roman on 23/04/2024.
//

import Foundation

struct ApiConstants {
    static let baseUrl = "https://gbfs.urbansharing.com/rowermevo.pl/"
    static let informationUrl = baseUrl + "station_information.json"
    static let statusUrl = baseUrl + "/station_status.json"
}

enum NetworkError: Error {
    case missingUrl
}
