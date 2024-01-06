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
    
    private lazy var categoryList: [Category] = {
        var list: [Category] = []
        switch self.vehicle.type {
        case 
        }
        return list
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AddExpenseView {
    
    private func configure() {
        setTitle(title: "New expense for \(vehicle.name)")
        
        let mileageUnitsLabel = UILabel()
        mileageUnitsLabel.text = vehicle.units == "imperial" ? "mi":"km"
        mileageUnitsLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        mileageUnitsLabel.translatesAutoresizingMaskIntoConstraints = false
        mileageUnitsLabel.setContentHuggingPriority(.required, for: .horizontal)
        contentView.addSubview(mileageUnitsLabel)
        mileageUnitsLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mileageUnitsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        let mileageTextField = InputTextField()
        mileageTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mileageTextField)
        mileageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mileageTextField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mileageTextField.trailingAnchor.constraint(equalTo: mileageUnitsLabel.leadingAnchor, constant: 10.0).isActive = true
        
        
        
        mileageTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        insertContentView()
        
    }
}
