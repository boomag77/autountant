//
//  AddExpenseView.swift
//  Autountant
//
//  Created by Sergey on 12/20/23.
//

import UIKit

class AddExpenseView: PopupInputWindowView {
    
    var vehicle: Vehicle! {
        didSet {
            configure()
        }
    }
    
//    private lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        //label.text = "New expense for \(self.vehicle.name)"
//        label.font = UIFont.preferredFont(forTextStyle: .footnote)
//        label.adjustsFontForContentSizeCategory = true
//        label.textColor = .black.withAlphaComponent(0.8)
//        label.contentMode = .center
//        label.setContentHuggingPriority(.required, for: .horizontal)
//        
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.5
//        return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AddExpenseView {
    
    private func configure() {
        
//        contentView.addSubview(titleLabel)
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0).isActive = true
//        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
//        insertContentView()
        
    }
}
