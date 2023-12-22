//
//  ExpenseCellView.swift
//  Autountant
//
//  Created by Sergey on 12/19/23.
//

import UIKit

class ExpenseCellView: UIView {
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .left
        label.textColor = .systemGray.withAlphaComponent(0.8)
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .left
        label.textColor = .black.withAlphaComponent(0.8)
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .right
        label.textColor = .black.withAlphaComponent(0.8)
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .systemGray6
        
        addSubview(dateLabel)
        addSubview(categoryLabel)
        addSubview(amountLabel)
        
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        
        amountLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20.0).isActive = true
        amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20.0).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: amountLabel.leadingAnchor, constant: -20.0).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        
    }
    
}
