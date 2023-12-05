//
//  ViewController.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//

import UIKit
import CoreData

class VehiclesViewController: UIViewController {
    
    var dataManager: DataManager!
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var addVehicleButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Register new vehicle", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
    }
    
    @objc private func addButtonPressed(_ button: UIButton) {
        showAddVehicleView()
    }
    
    @objc private func toggleCurrentVehicleCheckBox(_ checkBox: UISwitch) {
        if checkBox.isOn {
            checkBox.isOn = false
        } else {
            checkBox.isOn = true
        }
    }
    
    private func showAddVehicleView() {
        let addVehicleView = AddVehicleView()
        view.addSubview(addVehicleView)
        
        addVehicleView.translatesAutoresizingMaskIntoConstraints = false
        addVehicleView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        addVehicleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0).isActive = true
        addVehicleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0).isActive = true
        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        view.insertSubview(overlay, belowSubview: addVehicleView)
        addVehicleView.backgroundOverlay = overlay
        
        addVehicleView.dataManager = dataManager
    }
    
    private func setup() {
        
        view.backgroundColor = .white
        
        view.addSubview(addVehicleButton)
        view.addSubview(tableView)
        
        //MARK: Save button layout
        addVehicleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        addVehicleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        addVehicleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        addVehicleButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        //MARK: TableView layout
        tableView.topAnchor.constraint(equalTo: addVehicleButton.bottomAnchor, constant: 20.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
}

extension VehiclesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getCount(forEntity: "Vehicle")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currVehicle = dataManager.vehicleResultsController.object(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "vehicle", for: indexPath) as! VehicleTableViewCell
        
        cell.vehicle = currVehicle
        cell.setUp()
    
        return cell
    }
    
}

extension VehiclesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let vehicleToDelete = dataManager.vehicleResultsController.object(at: indexPath)
        
        let actionDelete = UIContextualAction(style: .destructive,
                                              title: nil) { _,_,_ in
            self.dataManager.deleteVehicle(vehicleToDelete)
        }
        actionDelete.image = UIImage(systemName: "trash")
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedVehicle = dataManager.vehicleResultsController.object(at: indexPath)
        
        if selectedVehicle.current == false {
            dataManager.setVehicleCurrent(selectedVehicle)
        }
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

extension VehiclesViewController: TabBarDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        dataManager = DataManager(units: .imperial)
        
        //dataManager.dataPresenter = self
        dataManager.vehicleResultsController.delegate = self
        
        tableView.register(VehicleTableViewCell.self, forCellReuseIdentifier: "vehicle")
        setup()
        
        if dataManager.getCount(forEntity: "Vehicle") == 0 {
            showAddVehicleView()
        }
        
    }
    
    
}
