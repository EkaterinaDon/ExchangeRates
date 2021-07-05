//
//  ViewController.swift
//  ExchangeRates
//
//  Created by Ekaterina on 4.07.21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var collectionView: UICollectionView = {
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
            collectionView.register(RateCollectionViewCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
            collectionView.backgroundColor = .white
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    let networkManager = NetworkManager()
    var rates: [Rate] = []
    
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }
    
    // MARK: - LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        networkManager.getRates() { rates in
            self.rates = rates
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - UI Setup

extension ViewController {
    
    private func setupUI() {
        
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        self.collectionView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 346, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        return layout
    }
}

// MARK: - UICollectionViewDelegate & Data Source

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? RateCollectionViewCell else {
            return dequeuedCell
        }
        
        let rate = rates[indexPath.row]
        cell.configureCell(model: rate)
        cell.makeShadowAndRadius(opacity: 0.5, radius: 8.0)
        return cell
    }
}
