//
//  StationView.swift
//  TriBikes
//
//  Created by Roman on 28/04/2024.
//

import UIKit

final class StationView: UIView {
    private enum Layout {
        static let verticalMargin: CGFloat = 20
        static let horizontalMargin: CGFloat = 16
        static let titleFontSize: CGFloat = 32
        static let subtitleFontSize: CGFloat = 12
        static let numberFontSize: CGFloat = 44
        static let iconSize: CGFloat = 24
    }

    var titleLabel: UILabel = UILabel()
    var subTilteLabel: UILabel = UILabel()
    var bikeImageView: UIImageView = UIImageView()
    var bikeCountLabel: UILabel = UILabel()
    var bikeSubtitleLabel: UILabel = UILabel()
    var lockImageView: UIImageView = UIImageView()
    var lockCountLabel: UILabel = UILabel()
    var lockSubtitleLabel: UILabel = UILabel()
    var headerStackView: UIStackView = UIStackView()
    var bikeStackView: UIStackView = UIStackView()
    var lockStackView: UIStackView = UIStackView()
    var contentStackView: UIStackView = UIStackView()

    private let distanceAtributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: Layout.subtitleFontSize, weight: .bold),
        .foregroundColor: UIColor.black
    ]

    private let adressAtributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: Layout.subtitleFontSize),
        .foregroundColor: UIColor.black
    ]

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
        let adressText = NSAttributedString(string: station.information.address, attributes: adressAtributes)
        
        if let distance = station.distance {
            let distanceText =  NSMutableAttributedString(string: dispalyDistance(distance), attributes: distanceAtributes)
            distanceText.append(adressText)
            subTilteLabel.attributedText = distanceText
        } else {
            subTilteLabel.attributedText = adressText
        }

        titleLabel.text = station.information.name
        
        bikeCountLabel.text = String(station.status.numBikesAvailable)
        lockCountLabel.text = String(station.status.numDocksAvailable)
    }

    private func addSubviews() {
        [titleLabel, subTilteLabel].forEach { headerStackView.addArrangedSubview($0) }
        [bikeImageView, bikeCountLabel, bikeSubtitleLabel].forEach { bikeStackView.addArrangedSubview($0) }
        [lockImageView, lockCountLabel, lockSubtitleLabel].forEach { lockStackView.addArrangedSubview($0) }
        [bikeStackView, lockStackView].forEach { contentStackView.addArrangedSubview($0) }
    
        [headerStackView, contentStackView ].forEach { addSubview($0) }
    }


    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bikeImageView.heightAnchor.constraint(equalToConstant: Layout.iconSize),
            bikeImageView.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            lockImageView.heightAnchor.constraint(equalToConstant: Layout.iconSize),
            lockImageView.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            headerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.verticalMargin),
            headerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.horizontalMargin),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.horizontalMargin),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.horizontalMargin),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Layout.verticalMargin)
        ])
    }

    private func setupViews() {
        backgroundColor = .white
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .vertical
        headerStackView.spacing = 4

        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .horizontal
        contentStackView.spacing = 0
        contentStackView.distribution = .fillEqually

        titleLabel.font = .systemFont(ofSize: Layout.titleFontSize, weight: .bold)
        titleLabel.textColor = .black
        subTilteLabel.font = .systemFont(ofSize: Layout.subtitleFontSize, weight: .regular)
        subTilteLabel.textColor = .black

        bikeStackView.translatesAutoresizingMaskIntoConstraints = false
        bikeStackView.axis = .vertical
        bikeStackView.spacing = 4
        bikeStackView.distribution = .equalCentering

        bikeImageView.image = UIImage(named: "bike")
        bikeImageView.contentMode = .scaleAspectFit
        bikeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        bikeCountLabel.font = .systemFont(ofSize: Layout.numberFontSize, weight: .regular)
        bikeCountLabel.textColor = .primarytGreen
        bikeCountLabel.textAlignment = .center

        bikeSubtitleLabel.font = .systemFont(ofSize: Layout.subtitleFontSize, weight: .regular)
        bikeSubtitleLabel.text = "Bikes available"
        bikeSubtitleLabel.textColor = .black
        bikeSubtitleLabel.textAlignment = .center

        lockStackView.translatesAutoresizingMaskIntoConstraints = false
        lockStackView.axis = .vertical
        lockStackView.spacing = 4
        
        lockImageView.image = UIImage(named: "lock")
        lockImageView.contentMode = .scaleAspectFit
        lockImageView.translatesAutoresizingMaskIntoConstraints = false

        lockCountLabel.font = .systemFont(ofSize: Layout.numberFontSize, weight: .regular)
        lockCountLabel.textColor = .black
        lockCountLabel.textAlignment = .center

        lockSubtitleLabel.font = .systemFont(ofSize: Layout.subtitleFontSize, weight: .regular)
        lockSubtitleLabel.text = "Places available"
        lockSubtitleLabel.textColor = .black
        lockSubtitleLabel.textAlignment = .center
    }

    private func dispalyDistance(_ distance: Int) -> String {
        if distance < 1000 {
            let result = Double(distance)/100 * 100
            return "\(Int(result)) m · "
        } else {
            let newDistance = Double(distance)/1000
            let result = round(newDistance)
            return "\(Int(result)) km · "
        }
    }
}

