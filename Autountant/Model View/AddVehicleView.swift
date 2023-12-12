//
//  AddVehicleView.swift
//  Autountant
//
//  Created by Sergey on 11/30/23.
//

import UIKit

class AddVehicleView: UIView {
    
    var active: Bool = false {
        didSet {
            currentVehicleCheckBox.isOn = active
        }
    }
    weak var dataManager: DataManager?
    var backgroundOverlay: UIView?
    
    private lazy var vehicleNameTextField: InputTextField = {
        let textField = InputTextField()
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
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .systemBlue
        config.cornerStyle = .capsule
        button.configuration = config
        
        //button.sizeToFit()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Close", for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var currentVehicleCheckBox: UISwitch = {
        let checkBox = UISwitch()
        checkBox.preferredStyle = .automatic
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.isOn = false
        checkBox.addTarget(self, action: #selector(toggleCurrentVehicleCheckBox), for: .touchUpInside)
        return checkBox
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AddVehicleView {
    
    private func setup() {
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 20
        
        
        addSubview(vehicleNameTextField)
        addSubview(vehicleMileageTextField)
        addSubview(currentVehicleCheckBox)
        addSubview(setCurrentLabel)
        addSubview(saveButton)
        addSubview(cancelButton)
        
        vehicleNameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 30.0).isActive = true
        vehicleNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        vehicleNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        
        vehicleMileageTextField.topAnchor.constraint(equalTo: vehicleNameTextField.bottomAnchor, constant: 10.0).isActive = true
        vehicleMileageTextField.leadingAnchor.constraint(equalTo: vehicleNameTextField.leadingAnchor).isActive = true
        vehicleMileageTextField.trailingAnchor.constraint(equalTo: vehicleNameTextField.trailingAnchor).isActive = true
        
        currentVehicleCheckBox.topAnchor.constraint(equalTo: vehicleMileageTextField.bottomAnchor, constant: 10).isActive = true
        currentVehicleCheckBox.leadingAnchor.constraint(equalTo: vehicleNameTextField.leadingAnchor).isActive = true
        //currentVehicleCheckBox.widthAnchor.constraint(equalTo: currentVehicleCheckBox.heightAnchor).isActive = true
        
        setCurrentLabel.leadingAnchor.constraint(equalTo: currentVehicleCheckBox.trailingAnchor, constant: 20.0).isActive = true
        setCurrentLabel.trailingAnchor.constraint(equalTo: vehicleNameTextField.trailingAnchor).isActive = true
        setCurrentLabel.centerYAnchor.constraint(equalTo: currentVehicleCheckBox.centerYAnchor).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: currentVehicleCheckBox.bottomAnchor, constant: 30.0).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10.0).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: vehicleNameTextField.leadingAnchor).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: vehicleNameTextField.trailingAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30.0).isActive = true
        
    }
}

extension AddVehicleView {
    
    @objc private func saveButtonPressed(_ button: UIButton) {
        
        var success: Bool = true
        
        guard let name = vehicleNameTextField.text,
              let mileage = vehicleMileageTextField.text,
              let intMileage = Int64(mileage)
        else { return }
        
//        if self.vehicleNameTextField.text == "" &&
//            self.vehicleMileageTextField.text == "" { return }
        
        
        dataManager?.registerNewVehicle(name: name,
                                        mileage: intMileage,
                                        type: .gasoline,
                                        units: .imperial,
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
            
            self.removeFromSuperview()
            self.backgroundOverlay?.removeFromSuperview()
        }
        
    }
    
    @objc private func cancelButtonPressed(_ button: UIButton) {
        removeFromSuperview()
        backgroundOverlay?.removeFromSuperview()
    }
    
    @objc private func toggleCurrentVehicleCheckBox(_ checkBox: UISwitch) {
        if self.active {
            self.active = false
        } else {
            self.active = true
        }
        
    }
}
