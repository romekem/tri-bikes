//
//  StationAnnotation.swift
//  TriBikes
//
//  Created by Roman on 28/04/2024.
//

import MapKit

class StationAnnotation: NSObject, MKAnnotation {
    var bikesCount: Int
    var coordinate: CLLocationCoordinate2D

    init(bikesCount: Int, coordinate: CLLocationCoordinate2D) {
        self.bikesCount = bikesCount
        self.coordinate = coordinate
    }
}
