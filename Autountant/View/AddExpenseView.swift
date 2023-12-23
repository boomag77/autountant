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
            setup()
        }
    }
    
    private lazy var vehicleLabelView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New expense for \(self.vehicle.name)"
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black.withAlphaComponent(0.8)
        label.contentMode = .center
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func closeButtonPressed(_ sender: UIButton) {
        self.remove()
    }
    
}

extension AddExpenseView {
    
    private func setup() {
        
        addSubview(titleLabel)
        addSubview(cancelButton)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -20.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30.0).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        
    }
}
