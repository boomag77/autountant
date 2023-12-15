//
//  DataManager.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//

import Foundation
import CoreData

enum DataManagerError: String, Error  {
    case nameAlreadyExists = "Vehicle with this name already exists!"
    case invalidInputFormat
}

final class DataManager {
    
    
    private var container: NSPersistentContainer = AppDelegate.shared.container
    
    var vehicleResultsController: NSFetchedResultsController<Vehicle>!
    var expensesResultController: NSFetchedResultsController<Expense>!
    
    init() {
        
//        self.container = NSPersistentContainer(name: "Storage")
//        container.loadPersistentStores { _, error in
//            if let error = error {
//                print("Unresolved error \(error)")
//            }
//        }
        
        let vehicleRequest = Vehicle.createFetchRequest()
        let sortVehicles = NSSortDescriptor(key: "name", ascending: true)
        vehicleRequest.sortDescriptors = [sortVehicles]
        vehicleResultsController = NSFetchedResultsController(fetchRequest: vehicleRequest,
                                                       managedObjectContext: container.viewContext,
                                                       sectionNameKeyPath: nil,
                                                       cacheName: nil)
        try? vehicleResultsController.performFetch()
        
        let expensesRequest = Expense.createFetchRequest()
        let sortExpenses = NSSortDescriptor(key: "date", ascending: false)
        expensesRequest.sortDescriptors = [sortExpenses]
        expensesResultController = NSFetchedResultsController(fetchRequest: expensesRequest,
                                                              managedObjectContext: container.viewContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        try? expensesResultController.performFetch()
        
    }
    
    private func saveContext(completion: ((DataManagerError) -> Void)? = nil) {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print ("Error while saving context to Container \(error)")
            }
        }
    }
}




extension DataManager {
    
    //MARK: Vehicles methods
    
    func getActiveVehicle() -> Vehicle? {
        
        let request = Vehicle.createFetchRequest()
        let predicate = NSPredicate(format: "active = %@", NSNumber(booleanLiteral: true))
        request.predicate = predicate
        do {
            if let currentVehicle = try container.viewContext.fetch(request).first {
                return currentVehicle
            }
        } catch {
            print("Could not fetch active vehicle")
        }
        return nil
    }
    
    func registerNewVehicle(name: String,
                            mileage: Int64,
                            type: VehicleType,
                            units: Units,
                            currency: Currency,
                            active: Bool,
                            completion: ((DataManagerError?) -> Void)? = nil) {
        
        if vehicleExists(vehicleName: name) {
            completion?(.nameAlreadyExists)
            return
        }
        if active {
            resetCurrentVehicle()
        }
        
        let newVehicle = Vehicle(context: self.container.viewContext)
        
        newVehicle.name = name
        newVehicle.mileage = mileage
        newVehicle.type = type.rawValue
        newVehicle.units = units.rawValue
        newVehicle.currency = currency.rawValue
        newVehicle.active = getVehiclesCount() > 0 ? active:true
        
        self.saveContext()
        
        
    }
    
    func getVehiclesCount() -> Int {
        return vehicleResultsController.fetchedObjects?.count ?? 0
    }
    
    private func updateVehicleMileage(vehicle: Vehicle, newMileage: Int64) {
        let request = Vehicle.createFetchRequest()
        let predicate = NSPredicate(format: "name = %@", vehicle.name)
        request.predicate = predicate
        if let vehicle = try? container.viewContext.fetch(request).first {
            vehicle.mileage = newMileage
            saveContext()
        } else {
            print("Could not fetch vehicle to update it's mileage!")
        }
    }
    
    func setCurrent(vehicleName: String) {
        let request = Vehicle.createFetchRequest()
        let predicate = NSPredicate(format: "name = %@", vehicleName)
        request.predicate = predicate
        
        do {
            resetCurrentVehicle()
            let newCurrentVehicle = try container.viewContext.fetch(request).first
            newCurrentVehicle?.active = true
        } catch {
            print("Could not fetch object to set it as ACTIVE")
        }
        saveContext()
    }
    
    private func resetCurrentVehicle() {
        let request = Vehicle.createFetchRequest()
        let predicate = NSPredicate(format: "active = %@", NSNumber(booleanLiteral: true))
        request.predicate = predicate
        
        do {
            let currentVehicle = try container.viewContext.fetch(request)
            if !currentVehicle.isEmpty {
                currentVehicle.forEach { $0.active = false }
            }
        } catch {
            print("Could not fetch current vehicle for resetting")
        }
        saveContext()
    }
    
    func vehicleExists(vehicleName: String) -> Bool {
        
        let request = Vehicle.createFetchRequest()
        let predicate = NSPredicate(format: "name == %@", vehicleName)
        request.predicate = predicate
        if let vehicles = try? container.viewContext.fetch(request) {
            return !vehicles.isEmpty
        } else {
            print("Could not fetch vehicle with name \(vehicleName)")
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
}


