//
//  StationListViewController.swift
//  TriBikes
//
//  Created by Roman on 27/04/2024.
//

import UIKit
import Combine
import CoreLocation

protocol StationListViewControllerDelegate: AnyObject {
    func didSelectStation(_ station: BikeStation)
    func didReceiveError(_ error: Error)
}

final class StationListViewController: UIViewController {
    private enum Layout {
        static let verticalMargin: CGFloat = 20
        static let horizontalMargin: CGFloat = 16
        static let collectionViewSpacing: CGFloat = 8
        static let cellHeight: CGFloat = 208
    }

    private enum Section {
        case main
    }

    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, BikeStation>

    weak var delegate: StationListViewControllerDelegate?

    private lazy var colectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private var cancellables = Set<AnyCancellable>()

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, BikeStation> = {
        UICollectionViewDiffableDataSource(collectionView: colectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell: StationListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StationListCollectionViewCell.reuseIdentifier, for: indexPath) as? StationListCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.updateView(station: itemIdentifier)
            return cell
        }
    }()

    private let viewModel: StationListViewModel

    init(viewModel: StationListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupViews()
        addSubviews()
        setupConstraints()
        
        viewModel.fetchData()
    }

    private func bind() {
        viewModel.$stations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stations in
                self?.applySnapshot(items: stations)
            }
            .store(in: &cancellables)

        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self,
                      let error else { return }
                self.delegate?.didReceiveError(error)
            }
            .store(in: &cancellables)
    }

    private func addSubviews() {
        view.addSubview(colectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            colectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            colectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            colectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            colectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func setupViews() {
        colectionView.translatesAutoresizingMaskIntoConstraints = false
        colectionView.register(StationListCollectionViewCell.self, forCellWithReuseIdentifier: StationListCollectionViewCell.reuseIdentifier)
        colectionView.backgroundColor = .systemGray6
        colectionView.delegate = self
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let itemWidth = self.view.frame.width
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth),
                                                  heightDimension: .absolute(Layout.cellHeight))
            
            let groupHeight = Layout.cellHeight + Layout.collectionViewSpacing
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(groupHeight))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: .zero, leading: Layout.horizontalMargin, bottom: .zero, trailing: Layout.horizontalMargin)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            group.interItemSpacing = .fixed(Layout.collectionViewSpacing)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.contentInsets = .init(top: Layout.verticalMargin, leading: .zero, bottom: Layout.verticalMargin, trailing: .zero)
            return section
        }
    }

    private func applySnapshot(items: [BikeStation]) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
}

extension StationListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectStation(viewModel.stations[indexPath.row])
    }
}
