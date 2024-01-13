//
//  AddExpenseView.swift
//  Autountant
//
//  Created by Sergey on 12/20/23.
//

import UIKit

final class AddExpenseView: PopupInputWindowView {
    
    var vehicle: Vehicle! {
        didSet {
            configure()
        }
    }
    
    private lazy var defaultCategory: Category = {
        let type = VehicleType(rawValue: self.vehicle.type)
        switch type {
            case .electric:
                return .electricity
            default:
                return .fuel
        }
    }()
    
    private lazy var categoryList: [Category] = {
        var list: [Category] = Category.getList(for: self.vehicle.type)
        return list
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func showCategoriesList() {
        print("Showing categories list")
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
        mileageTextField.trailingAnchor.constraint(equalTo: mileageUnitsLabel.leadingAnchor, constant: -10.0).isActive = true
        
        let categoryLabel = TappableLabel()
        categoryLabel.text = self.defaultCategory.rawValue
        categoryLabel.setup()
        contentView.addSubview(categoryLabel)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: mileageTextField.bottomAnchor, constant: 10.0).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        
        
        //mileageTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        categoryLabel.addTarget(self, action: #selector(showCategoriesList), for: .touchUpInside)
        
        
        insertContentView()
        
    }
}

