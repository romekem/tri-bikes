//
//  StationDetailsViewController.swift
//  TriBikes
//
//  Created by Roman on 28/04/2024.
//

import UIKit
import MapKit
import GoogleMapsTileOverlay
import Combine

final class StationDetailsViewController: UIViewController {
    private enum Layout {
        static let cornerRadius: CGFloat = 16
    }

    private let mapView: MKMapView = MKMapView()
    private let stationView: StationView = StationView()
    private let viewModel: StationDetailsViewModel
    private var cancellables = Set<AnyCancellable>()

    private var stationLocation: CLLocation {
        CLLocation(latitude: viewModel.station.information.lat, longitude: viewModel.station.information.lon)
    }

    init(viewModel: StationDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addSubviews()
        setupConstraints()

        centerToLocation()
    }

    private func addSubviews() {
        [mapView, stationView].forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            stationView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -32),
            stationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])
    }

    private func setupViews() {
        view.backgroundColor = .white

        setupMapView()

        stationView.translatesAutoresizingMaskIntoConstraints = false
        stationView.updateView(station: viewModel.station)
        stationView.layer.cornerRadius = Layout.cornerRadius
        stationView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func setupMapView() {
        let mapConfig = MKStandardMapConfiguration()
        mapConfig.pointOfInterestFilter = .init(including: [])

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        mapView.delegate = self
        mapView.preferredConfiguration = mapConfig
        mapView.showsUserLocation = true
        mapView.register(StationAnnotationView.self, forAnnotationViewWithReuseIdentifier: StationAnnotationView.identifier)

        guard let jsonURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json"),
              let tileOverlay = try? GoogleMapsTileOverlay(jsonURL: jsonURL) else { return }

        tileOverlay.canReplaceMapContent = true
        mapView.addOverlay(tileOverlay, level: .aboveRoads)
    }

    private func centerToLocation() {
        var regionRadius: Double = 1000
        if let distance = viewModel.station.distance {
            let additionalRadius: Double = distance > 500 ? 2000 : 500
            regionRadius = Double(distance) + additionalRadius
        }
        mapView.centerToLocation(stationLocation, regionRadius: regionRadius)

        let location = CLLocationCoordinate2D(latitude: viewModel.station.information.lat, longitude: viewModel.station.information.lon)
        let annotation = StationAnnotation(bikesCount: viewModel.station.status.numBikesAvailable, coordinate: location)
        mapView.addAnnotation(annotation)
    }
}

extension StationDetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        } else {
            let bikeAnnotation = annotation as? StationAnnotation
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: StationAnnotationView.identifier, for: annotation) as? StationAnnotationView
            annotationView?.stationAnnotation = bikeAnnotation
            return annotationView
        }
        
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let tileOverlay = overlay as? MKTileOverlay {
            return MKTileOverlayRenderer(tileOverlay: tileOverlay)
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
