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
        let view = UIControl()
        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0).isActive = true
        view.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -20.0).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        let label = UILabel(frame: view.bounds)
        view.addSubview(label)
        label.text = "self.vehicle.name"
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.addTarget(self, action: #selector(vehicleLabelTapped), for: .touchUpInside)
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
    
    @objc private func vehicleLabelTapped() {
        print("vehicle label tapped")
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
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20.0).isActive = true
        
        cancelButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0).isActive = true
        
        
        
    }
}
