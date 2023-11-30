//
//  AddVehicleView.swift
//  Autountant
//
//  Created by Sergey on 11/30/23.
//

import UIKit

class AddVehicleView: UIView {
    
    var setCurrent: Bool = false {
        didSet {
            currentVehicleCheckBox.isOn = setCurrent
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
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Close", for: .normal)
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
        currentVehicleCheckBox.widthAnchor.constraint(equalTo: currentVehicleCheckBox.heightAnchor).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: currentVehicleCheckBox.bottomAnchor, constant: 10.0).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: vehicleNameTextField.leadingAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: vehicleNameTextField.trailingAnchor).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10.0).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: vehicleNameTextField.leadingAnchor).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: vehicleNameTextField.trailingAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30.0).isActive = true
        
    }
}

extension AddVehicleView {
    
    @objc private func saveButtonPressed(_ button: UIButton) {
        
        if self.vehicleNameTextField.text == "" &&
            self.vehicleMileageTextField.text == "" { return }
        
        
        dataManager?.registerNewVehicle(vehicleNameTextField.text!,
                                       vehicleMileageTextField.text!,
                                       false,
                                        self.setCurrent)
        self.vehicleNameTextField.text = ""
        self.vehicleMileageTextField.text = ""
        
        removeFromSuperview()
        backgroundOverlay?.removeFromSuperview()
    }
    
    @objc private func cancelButtonPressed(_ button: UIButton) {
        removeFromSuperview()
        backgroundOverlay?.removeFromSuperview()
    }
    
    @objc private func toggleCurrentVehicleCheckBox(_ checkBox: UISwitch) {
        if self.setCurrent {
            self.setCurrent = false
        } else {
            self.setCurrent = true
        }
    }
}
