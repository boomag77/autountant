//
//  DataManager.swift
//  Autountant
//
//  Created by Sergey Burdakov on 11/19/23.
//

import Foundation
import CoreData

class DataManager {
    
    enum DataManagerError: Error {
        case wrongVehicleName(ErrorMessage)
        case wrongVehicleMileage(ErrorMessage)
    }
    
    enum ErrorMessage: String {
        case vehicleName = "Wrong format or empty name"
        case vehicleMileage = "Wrong mileage format"
    }
    
    enum SuccessMessage: String {
        case vehicleSaved = "Vehicle saved successfully"
        case expenseSaved = "Expense saved successfully"
    }
    
    private var container: NSPersistentContainer!
    
    var vehicleResultsController: NSFetchedResultsController<Vehicle>!
    var expensesResultController: NSFetchedResultsController<Expense>!
    
    private var units: Units
    
    private var currentVehicle: Vehicle? {
        willSet {
            print("Previous current Vehicle - \(currentVehicle?.name ?? "not defined")")
        }
        didSet {
            print("New current vehicle - \(currentVehicle?.name ?? "not defined")")
        }
    }
    
    init(units: Units) {
        
        self.units = units
        
        initializeContainer()
        setUpResultsControllers()
        
    }
    
    private func initializeContainer() {
        self.container = NSPersistentContainer(name: "Autountant")
        container.loadPersistentStores { _, error in
            if let error = error {
                //TODO: add handler of DataManager errors
                //print("Unresolved error \(error)")
            }
        }
    }
    
    private func setUpResultsControllers() {
        
        let vehicleRequest = Vehicle.createFetchRequest()
        let sortVehicles = NSSortDescriptor(key: "name", ascending: true)
        vehicleRequest.sortDescriptors = [sortVehicles]
        vehicleResultsController = NSFetchedResultsController(fetchRequest: vehicleRequest,
                                                       managedObjectContext: container.viewContext,
                                                       sectionNameKeyPath: nil,
                                                       cacheName: nil)
        try? vehicleResultsController.performFetch()
        
        if let vehicles = vehicleResultsController.fetchedObjects {
            for vehicle in vehicles {
                if vehicle.current {
                    currentVehicle = vehicle
                }
            }
        }
        
        let expensesRequest = Expense.createFetchRequest()
        let sortExpenses = NSSortDescriptor(key: "date", ascending: false)
        expensesRequest.sortDescriptors = [sortExpenses]
        expensesResultController = NSFetchedResultsController(fetchRequest: expensesRequest,
                                                              managedObjectContext: container.viewContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
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
    
    func registerNewVehicle(_ name: String,
                            _ mileage: String,
                            _ type: VehicleType,
                            _ current: Bool) {
        
        var errors: [DataManagerError] = []
        
        if name.count > 10 { errors.append(.wrongVehicleName(.vehicleName)) }
        if let _: Int64 = Int64(mileage) {
            
        } else {
            
        }
        
        let newVehicle = Vehicle(context: self.container.viewContext)
        newVehicle.name = name
        newVehicle.mileage = mileage
        newVehicle.type = type.rawValue
        newVehicle.current = getCount(forEntity: "Vehicle") > 0 ? current:true

        
        self.saveContext()
        
//        if let reason = errorReason {
//            completion(.failure(DataManagerError.failureReason(reason)))
//        } else {
//            completion(.success("Vehicle successfully saved!"))
//        }
        
        if newVehicle.current ==  true {
            self.currentVehicle = newVehicle
        }
    }
    
    func registerNewExpense(_ date: Date,
                            _ vehicle_name: String,
                            _ mileage: String,
                            _ category: Category,
                            _ amount: Double,
                            _ note: String?) {
        
        guard let currentVehicle = self.currentVehicle else { return }
        
        let newExpense = Expense(context: container.viewContext)
        newExpense.date = Date()
        newExpense.vehicle_name = currentVehicle.name
        newExpense.mileage = mileage
        newExpense.category = category.rawValue
        newExpense.amount = amount
        if let noteText = note {
            newExpense.note = noteText
        }
        
        saveContext()
    }
    
    private func editObject(inEntity entityName: Entity = .Vehicle,
                            _ newName: String?,
                            _ newMileage: Int?,
                            _ newCurrent: Bool?) {
        
        //TODO: edit Vehicle object, replace newName in all relevant Expenses!
        
        saveContext()
    }
    
    private func editObject(inEntity entityName: Entity = .Expense,
                            _ newVehcileName: String?,
                            _ newAmount: Double?,
                            _ newDate: Date?,
                            _ newCategory: Category?,
                            _ newMileage: Int?,
                            _ newNote: String?) {
        
        //TODO: edit Expense object, correct Vehcile current mileage and Stat!
        
        saveContext()
    }
    
    func getCount(forEntity entityName: String) -> Int {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let count = try container.viewContext.count(for: request)
            return count
        } catch {
            // TODO: add handler of DataManager errors
            return 0
        }
    }
    
    func vehicleExists(_ vehicleName: String) -> Bool {
        
        let request = Vehicle.createFetchRequest()
        let predicate = NSPredicate(format: "name = %@", vehicleName)
        request.predicate = predicate
        do {
            let count = try container.viewContext.count(for: request)
            return count > 0
        } catch {
            // TODO: add handler of DataManager errors
            return false
        }
    }
    
    func deleteVehicle(_ vehicleToDelete: Vehicle) {
        
        container.viewContext.delete(vehicleToDelete)
        
        saveContext()
        
    }
    
    func setVehicleCurrent(_ newCurrentVehicle: Vehicle) {
        
        if let prevCurrVeh = self.currentVehicle {
            let request = Vehicle.createFetchRequest()
            let predicate = NSPredicate(format: "name = %@", prevCurrVeh.name)
            request.predicate = predicate
            let vehicle = try? container.viewContext.fetch(request).first
            if let vehicle = vehicle {
                vehicle.current = false
                saveContext()
            }
        }
        
        let request = Vehicle.createFetchRequest()
        let predicate = NSPredicate(format: "name = %@", newCurrentVehicle)
        request.predicate = predicate
        let vehicle = try? container.viewContext.fetch(request).first
        if let vehicle = vehicle {
            vehicle.current = true
            saveContext()
            self.currentVehicle = vehicle
        }
    }
}

