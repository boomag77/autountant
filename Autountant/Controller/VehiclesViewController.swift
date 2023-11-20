//
//  ViewController.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//

import UIKit
import CoreData

class VehiclesViewController: UIViewController {
    
    var container: NSPersistentContainer!
    var resultsController: NSFetchedResultsController<Vehicle>!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mileageTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        container = NSPersistentContainer(name: "Autountant")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        let request = Vehicle.createFetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        resultsController = NSFetchedResultsController(fetchRequest: request,
                                                       managedObjectContext: container.viewContext,
                                                       sectionNameKeyPath: nil,
                                                       cacheName: nil)
        resultsController.delegate = self
        try? resultsController.performFetch()
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if self.nameTextField.text == "" && self.mileageTextField.text == "" {return}
        DispatchQueue.main.async { [unowned self] in
            let newVehicle = Vehicle(context: self.container.viewContext)
            newVehicle.vehicle_id = "1"
            newVehicle.name = nameTextField.text!
            newVehicle.mileage = mileageTextField.text!
            nameTextField.text = nil
            mileageTextField.text = nil
            self.saveContext()
            self.tableView.reloadData()
            
        }
        
    }
    
    func delete(_ vehicle: Vehicle) {
        let request = Vehicle.createFetchRequest()
        let predicate = NSPredicate(format: "name == %@", vehicle.name)
        request.predicate = predicate
        do {
            let vehicle = try container.viewContext.fetch(request)
            if !vehicle.isEmpty {
                container.viewContext.delete(vehicle.first!)
                self.saveContext()
                tableView.reloadData()
            }
        } catch let error as NSError {
            print("Could not fetch or delete object \(error)")
        }
    }
    
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
                
            } catch {
                print("An error occured while saving: \(error)")
            }
        }
    }
}

extension VehiclesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vehicle", for: indexPath)
        let vehicle = resultsController.object(at: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = vehicle.name
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let vehicleForErasing = resultsController.object(at: indexPath)
        let actionDelete = UIContextualAction(style: .destructive,
                                              title: nil) { _,_,_ in
            self.delete(vehicleForErasing)
        }
        actionDelete.image = UIImage(systemName: "trash")
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
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
