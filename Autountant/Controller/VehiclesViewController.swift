//
//  ViewController.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//

import UIKit
import CoreData

final class VehiclesViewController: UIViewController {
    
    var dataManager: DataManager!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var vehicleNameTextField: InputTextField = {
        let textField = InputTextField()
        textField.placeholder = "Input your vehicle name"
        return textField
    }()
    
    private lazy var vehicleMileageTextField: InputTextField = {
        let textField = InputTextField()
        textField.placeholder = "Input your vehicle mileage"
        return textField
    }()
    
    private lazy var saveVehicleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        //button.layer.borderWidth = 1
        //button.layer.borderColor = UIColor.blue.cgColor
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var currentVehicleCheckBox: UISwitch = {
        let checkBox = UISwitch()
        checkBox.preferredStyle = .checkbox
        return checkBox
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        dataManager = DataManager(units: .imperial)
        dataManager.dataPresenter = self
        dataManager.vehicleResultsController.delegate = self
        
        tableView.register(VehicleTableViewCell.self, forCellReuseIdentifier: "vehicle")
        
        configureView()
        
    }
    
    @objc private func saveButtonPressed(_ button: UIButton) {
        if self.vehicleNameTextField.text == "" &&
            self.vehicleMileageTextField.text == "" { return }
        dataManager.registerNewVehicle(vehicleNameTextField.text!,
                                       vehicleMileageTextField.text!,
                                       false,
                                       true)
        self.vehicleNameTextField.text = ""
        self.vehicleMileageTextField.text = ""
    }
    
    private func configureView() {
        
        view.backgroundColor = .white
        
        view.addSubview(vehicleNameTextField)
        view.addSubview(vehicleMileageTextField)
        view.addSubview(saveVehicleButton)
        view.addSubview(tableView)
        //view.addSubview()
        
        vehicleNameTextField.translatesAutoresizingMaskIntoConstraints = false
        vehicleMileageTextField.translatesAutoresizingMaskIntoConstraints = false
        saveVehicleButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Vehicle name layout
        vehicleNameTextField
            .leadingAnchor
            .constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        vehicleNameTextField
            .trailingAnchor
            .constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        vehicleNameTextField
            .topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        vehicleNameTextField
            .heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        //MARK: Vehicle mileage layout
        vehicleMileageTextField
            .leadingAnchor
            .constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        vehicleMileageTextField
            .trailingAnchor
            .constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        vehicleMileageTextField
            .topAnchor
            .constraint(equalTo: vehicleNameTextField.bottomAnchor, constant: 20.0).isActive = true
        vehicleMileageTextField
            .heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        //MARK: Save button layout
        saveVehicleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        saveVehicleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        saveVehicleButton.topAnchor.constraint(equalTo: vehicleMileageTextField.bottomAnchor, constant: 20.0).isActive = true
        saveVehicleButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        //MARK: TableView layout
        tableView.topAnchor.constraint(equalTo: saveVehicleButton.bottomAnchor, constant: 20.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
}

extension VehiclesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getVehiclesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currVehicle = dataManager.vehicleResultsController.object(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "vehicle", for: indexPath) as! VehicleTableViewCell
        cell.cellView.fillLabels(name: currVehicle.name, mileage: currVehicle.mileage)
    
        return cell
    }
    
}

extension VehiclesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let vehicleForErasing = dataManager.vehicleResultsController.object(at: indexPath)
        let actionDelete = UIContextualAction(style: .destructive,
                                              title: nil) { _,_,_ in
            self.dataManager.deleteVehicle(vehicleForErasing)
        }
        actionDelete.image = UIImage(systemName: "trash")
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedVehicle = dataManager.vehicleResultsController.object(at: indexPath)
        //dataManager.setActive(selectedVehicle)
        
    }
    
}

extension VehiclesViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                tableView.reloadRows(at: [indexPath!], with: .none)
            case .move:
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
        @unknown default:
            fatalError()
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

extension VehiclesViewController: DataPresenter {
    
    
    
    func updateView() {
        tableView.reloadData()
    }
    
    
}
