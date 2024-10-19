//
//  TableViewCell.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 18.10.2024.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    private let titleLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private let priceLabel : UILabel = {
        let price = UILabel()
        price.font = UIFont.systemFont(ofSize: 14)
        price.textColor = .gray
        price.translatesAutoresizingMaskIntoConstraints = false
        
        return price
    }()
    
    private let container : UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.1
        container.layer.shadowRadius = 5
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(container)
        container.addSubview(priceLabel)
        container.addSubview(titleLabel)
    }
    
    
    private func setupConstraints() {
        
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            priceLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = String(product.price) + "$"
    }
}

