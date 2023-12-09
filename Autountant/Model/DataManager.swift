//
//  DataManager.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//

import Foundation
import CoreData

class DataManager {
    
    private var container: NSPersistentContainer!
    
    var vehicleResultsController: NSFetchedResultsController<Vehicle>!
    var expensesResultController: NSFetchedResultsController<Expense>!
    
    init() {
        
        
        self.container = NSPersistentContainer(name: "Autountant")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        
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
    
    private func fetchContainer() {
        try? vehicleResultsController.performFetch()
        try? expensesResultController.performFetch()
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
}


extension DataManager {
    
    //MARK: Vehicles methods
    
    func registerNewVehicle(_ name: String,
                       _ mileage: String,
                       _ electric: Bool,
                       _ units: String) {
        
        let newVehicle = Vehicle(context: self.container.viewContext)
        
        
        newVehicle.name = name
        newVehicle.mileage = Int64(mileage)!
        newVehicle.electric = electric
        newVehicle.units = units
        
        self.saveContext()
        
    }
    
    func getVehiclesCount() -> Int {
        return vehicleResultsController.fetchedObjects?.count ?? 0
    }
    
    private func getMaxIdNumber() -> Int32 {
        return Int32(vehicleResultsController.fetchedObjects?.count ?? 0)
    }
    
    private func updateVehicleMileage(_ vehicle: Vehicle, _ newMileage: UInt) {
        
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
}
