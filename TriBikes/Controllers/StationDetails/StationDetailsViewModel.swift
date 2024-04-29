//
//  StationDetailsViewModel.swift
//  TriBikes
//
//  Created by Roman on 28/04/2024.
//

import Resolver
import CoreLocation

final class StationDetailsViewModel {
    private(set) var station: BikeStation

    init(station: BikeStation) {
        self.station = station
    }
}
