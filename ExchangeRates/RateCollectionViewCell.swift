//
//  RateCollectionViewCell.swift
//  ExchangeRates
//
//  Created by Ekaterina on 4.07.21.
//

import UIKit

class RateCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)    
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deltaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configureCell(model: Rate) {
        nameLabel.text = model.nameLabelText()
        priceLabel.text = model.priceLabelText()
        deltaLabel.text = model.deltaLabelText()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(deltaLabel)
        
        NSLayoutConstraint.activate([
            
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2.0),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            self.priceLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 2.0),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.priceLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            self.deltaLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 2.0),
            self.deltaLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.deltaLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.deltaLabel.heightAnchor.constraint(equalToConstant: 30.0)
        ])
    }
}

// MARK: - Shadow and Radius

extension UIView {
    func makeShadowAndRadius(opacity: Float, radius: Float) {
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = CGFloat(radius)
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: CGFloat(radius)).cgPath
        self.layer.backgroundColor = UIColor.white.cgColor
    }
}
