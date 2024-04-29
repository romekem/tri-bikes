//
//  StationAnnotationView.swift
//  TriBikes
//
//  Created by Roman on 28/04/2024.
//

import MapKit

final class StationAnnotationView: MKAnnotationView {
    static let identifier: String = "StationAnnotationView"
    private enum Layout {
        static let verticalMargin: CGFloat = 4
        static let horizontalMargin: CGFloat = 8
        static let numberFontSize: CGFloat = 18
        static let iconSize: CGFloat = 16
        static let viewSize: CGRect = CGRect(x: 0, y: 0, width: 48, height: 24)
        static let spacing: CGFloat = 2
    }

    var bikeImageView: UIImageView = UIImageView()
    var bikeCountLabel: UILabel = UILabel()

    var stationAnnotation: StationAnnotation? {
        didSet {
            updateView()
        }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = Layout.viewSize
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
    
        addSubviews()
        setupConstraints()
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        stationAnnotation = nil
    }

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = Layout.viewSize.height / 2

        bikeCountLabel.font = .systemFont(ofSize: Layout.numberFontSize, weight: .semibold)
        bikeCountLabel.textColor = .black
        bikeCountLabel.translatesAutoresizingMaskIntoConstraints = false

        bikeImageView.image = UIImage(named: "bike")
        bikeImageView.contentMode = .scaleAspectFit
        bikeImageView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func addSubviews() {
        [bikeCountLabel, bikeImageView].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bikeImageView.heightAnchor.constraint(equalToConstant: Layout.iconSize),
            bikeImageView.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            bikeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.verticalMargin),
            bikeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.horizontalMargin),
            bikeCountLabel.topAnchor.constraint(equalTo: self.topAnchor),
            bikeCountLabel.trailingAnchor.constraint(equalTo: bikeImageView.leadingAnchor, constant: -Layout.spacing),
            bikeCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    private func updateView() {
        guard let stationAnnotation else { return }
        bikeCountLabel.text = String(stationAnnotation.bikesCount)
    }
}
