//
//  StationListCollectionViewCell.swift
//  TriBikes
//
//  Created by Roman on 23/04/2024.
//

import UIKit

class StationListCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = "StationListViewCell"

    private enum Layout {
        static let cornerRadius: CGFloat = 16
    }

    private let stationView: StationView = StationView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        addSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateView(station: BikeStation) {
        stationView.updateView(station: station)
    }

    private func addSubviews() {
        contentView.addSubview(stationView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stationView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupViews() {
        stationView.translatesAutoresizingMaskIntoConstraints = false
        stationView.layer.cornerRadius = Layout.cornerRadius
    }
}
