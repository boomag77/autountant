//
//  AddVehicleView.swift
//  Autountant
//
//  Created by Sergey on 11/30/23.
//

import UIKit

class AddVehicleView: PopupInputWindowView {
    
    var active: Bool = false {
        didSet {
            currentVehicleCheckBox.isOn = active
        }
    }
    weak var dataManager: DataManager?
    
    private lazy var vehicleNameTextField: InputTextField = {
        let textField = InputTextField()
        textField.font = UIFont.preferredFont(forTextStyle: .subheadline)
        textField.placeholder = "Input vehicle name here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var vehicleMileageTextField: InputTextField = {
        let textField = InputTextField()
        textField.placeholder = "Input vehicle's mileage here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var setCurrentLabel: UILabel = {
        let label = UILabel()
        label.text = "set new vehicle as current"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private lazy var saveButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Save", for: .normal)
//        
//        var config = UIButton.Configuration.filled()
//        config.baseForegroundColor = .white
//        config.baseBackgroundColor = .systemBlue
//        config.cornerStyle = .capsule
//        button.configuration = config
//        
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    private lazy var cancelButton: UIButton = {
//        let button = UIButton(type: .roundedRect)
//        button.setTitle("Close", for: .normal)
//        button.sizeToFit()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
//        return button
//    }()
    
    private lazy var currentVehicleCheckBox: UISwitch = {
        let checkBox = UISwitch()
        checkBox.preferredStyle = .automatic
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.isOn = false
        checkBox.addTarget(self, action: #selector(toggleCurrentVehicleCheckBox), for: .touchUpInside)
        return checkBox
    }()
    
    private lazy var unitsSelector: UISegmentedControl = {
        let selector = UISegmentedControl(items: Units.allValues)
        selector.selectedSegmentIndex = 0
        selector.translatesAutoresizingMaskIntoConstraints = false
        return selector
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func saveButtonPressed() {
        
        var success: Bool = true
        
        guard let name = vehicleNameTextField.text,
              let mileage = vehicleMileageTextField.text,
              let intMileage = Int64(mileage)
        else { return }
        
        let newVehicleUnits = Units(rawValue: unitsSelector.titleForSegment(at: unitsSelector.selectedSegmentIndex)!)!
        
        dataManager?.registerNewVehicle(name: name,
                                        mileage: intMileage,
                                        type: .gasoline,
                                        units: newVehicleUnits,
                                        currency: .usd,
                                        active: active) {
            error in
            if let error = error {
                print(error.rawValue)
                success  = false
            }
        }
        if success {
            self.vehicleNameTextField.text = ""
            self.vehicleMileageTextField.text = ""
            self.unitsSelector.selectedSegmentIndex = 0
            self.remove()
        }
        
    }
    
}

extension AddVehicleView {
    
    private func configure() {
        
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.lightGray.cgColor
//        layer.cornerRadius = 20
        
        contentView.addSubview(vehicleNameTextField)
        contentView.addSubview(vehicleMileageTextField)
        contentView.addSubview(currentVehicleCheckBox)
        contentView.addSubview(setCurrentLabel)
        contentView.addSubview(unitsSelector)
        
        vehicleNameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30.0).isActive = true
        vehicleNameTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        vehicleMileageTextField.topAnchor.constraint(equalTo: vehicleNameTextField.bottomAnchor, constant: 10.0).isActive = true
        vehicleMileageTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        currentVehicleCheckBox.topAnchor.constraint(equalTo: vehicleMileageTextField.bottomAnchor, constant: 10).isActive = true
        currentVehicleCheckBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        setCurrentLabel.leadingAnchor.constraint(equalTo: currentVehicleCheckBox.trailingAnchor, constant: 20.0).isActive = true
        setCurrentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        setCurrentLabel.centerYAnchor.constraint(equalTo: currentVehicleCheckBox.centerYAnchor).isActive = true
        
        unitsSelector.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        unitsSelector.topAnchor.constraint(equalTo: setCurrentLabel.bottomAnchor, constant: 20.0).isActive = true
        unitsSelector.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        unitsSelector.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        insertContentView()
        
    }
}

extension AddVehicleView {
    
    @objc private func toggleCurrentVehicleCheckBox(_ checkBox: UISwitch) {
        if self.active {
            self.active = false
        } else {
            self.active = true
        }
        
    }
}
