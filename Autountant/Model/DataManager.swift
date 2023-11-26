//
//  DataManager.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//

import Foundation
import CoreData

protocol DataPresenter: AnyObject {
    var dataManager: DataManager {get set}
    func updateView()
}

class DataManager {
    
    weak var dataPresenter: DataPresenter?
    private var container: NSPersistentContainer!
    private var resultsController: NSFetchedResultsController<Vehicle>!
    var units: Units
    
    init(units: Units) {
        self.units = units
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
        try? resultsController.performFetch()
    }
    
    private func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print ("Error while saving context to Container \(error)")
            }
        }
    }
    
    func registerNewVehicle(_ name: String,
                       _ milage: UInt,
                       _ electric: Bool,
                       _ current: Bool) {
        let newVehicle = Vehicle(context: self.container.viewContext)
        newVehicle.name = name
        newVehicle.vehicle_id = getMaxIdNumber() + 1
        newVehicle.mileage = String(milage)
        newVehicle.electric = electric
        newVehicle.current = current
        
        self.saveContext()
    }
    
    private func getMaxIdNumber() -> Int32 {
        return Int32(resultsController.fetchedObjects?.count ?? 0)
    }
    
    func vehicleExists(_ vehicleName: String) -> Bool {
        let request = Vehicle.createFetchRequest()
        let predicate = NSPredicate(format: "name == %@", vehicleName)
        request.predicate = predicate
        do {
            let vehicles = try container.viewContext.fetch(request)
            if vehicles.isEmpty { return false }
        } catch let error as NSError {
            print("Could not fetch or delete object \(error)")
        }
        return true
    }
    
    func deleteVehicle(_ vehicle: Vehicle) {
        let request = Vehicle.createFetchRequest()
        let predicate = NSPredicate(format: "name = %@", vehicle.name)
        request.predicate = predicate
        do {
            let vehicle = try container.viewContext.fetch(request)
            if !vehicle.isEmpty {
                container.viewContext.delete(vehicle.first!)
                self.saveContext()
            }
        } catch let error as NSError {
            print("Could not fetch or delete object \(error)")
        }
    }
    
    func registerExpense() {
        
    }
    
    func deleteExpense(expense: Expense) {
        
    }
    
    
}
