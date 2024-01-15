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
    
    private lazy var categoryList: [String] = {
        var list: [String] = Category.getList(for: self.vehicle.type).map { $0.rawValue }
        return list
    }()
    
    private lazy var categoryLabel: TappableLabel = {
        let label = TappableLabel()
        label.text = self.defaultCategory.rawValue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func showCategoriesList() {
        print("Showing categories list")
        let categoriesList = TappableLabelListView()
        categoriesList.itemsList = self.categoryList
        addSubview(categoriesList)
        categoriesList.translatesAutoresizingMaskIntoConstraints = false
        categoriesList.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor).isActive = true
        categoriesList.topAnchor.constraint(equalTo: categoryLabel.topAnchor).isActive = true
        categoriesList.trailingAnchor.constraint(equalTo: categoryLabel.trailingAnchor).isActive = true
        categoriesList.bottomAnchor.constraint(greaterThanOrEqualTo: categoryLabel.bottomAnchor, constant: 50.0).isActive = true
        //categoriesList.setContentHuggingPriority(.required, for: .vertical)
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

