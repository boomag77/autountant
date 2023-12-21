//
//  AddExpenseView.swift
//  Autountant
//
//  Created by Sergey on 12/20/23.
//

import UIKit

class AddExpenseView: UIView {
    
    weak var backgroundOverlay: UIView?
    var vehicle: Vehicle?
    
    
    
    private lazy var vehicleLabel: UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.0
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func closeButtonPressed(_ sender: UIButton) {
        removeFromSuperview()
        backgroundOverlay?.removeFromSuperview()
        
    }
    
}

extension AddExpenseView {
    
    private func setup() {
        
        backgroundColor = .red
        layer.borderWidth = 5.0
        layer.borderColor = UIColor.black.cgColor
        
        addSubview(vehicleLabel)
        addSubview(closeButton)
        vehicleLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        vehicleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        vehicleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        
        closeButton.topAnchor.constraint(equalTo: vehicleLabel.bottomAnchor, constant: 30.0).isActive = true
        closeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        
        
    }
}
