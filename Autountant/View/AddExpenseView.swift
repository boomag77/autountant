//
//  AddExpenseView.swift
//  Autountant
//
//  Created by Sergey on 12/20/23.
//

import UIKit

class AddExpenseView: PopupInputWindowView {
    
    weak var backgroundOverlay: UIView?
    var vehicle: Vehicle!
    
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
    
    func setup() {
        
        addSubview(titleLabel)
        addSubview(closeButton)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -20.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        
        closeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30.0).isActive = true
        closeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        
    }
}
