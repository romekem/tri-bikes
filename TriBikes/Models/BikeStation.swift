//
//  BikeStation.swift
//  TriBikes
//
//  Created by Roman on 28/04/2024.
//

import Foundation

struct BikeStation: Hashable {
    let information: StationInformation
    let status: StationStatus
    var distance: Int?
}
