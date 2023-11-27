//
//  DataManager.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//

import Foundation
import CoreData

protocol DataPresenter: AnyObject {
    func updateView()
}

class DataManager {
    
    weak var dataPresenter: DataPresenter?
    private var container: NSPersistentContainer!
    
    var vehicleResultsController: NSFetchedResultsController<Vehicle>
    var expensesResultController: NSFetchedResultsController<Expense>
    
    var units: Units
    
    init(units: Units) {
        self.units = units
        
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
    //MARK: Expenses methods
    
    func getExpensesCount() -> Int {
        return expensesResultController.fetchedObjects?.count ?? 0
    }
    
    func registerExpense(_ vehicle: Vehicle, _ category: Category, _ amount: Double, _ mileage: UInt, _ note: String) {
        let expense = Expense(context: self.container.viewContext)
        expense.date = Date()
        expense.mileage = String(mileage)
        expense.amount = amount
        expense.vehicle_id = vehicle.vehicle_id
        expense.note = note
        expense.category = category.rawValue
        self.saveContext()
        //self.fetchContainer()
        dataPresenter?.updateView()
    }
    
    func deleteExpense(expenseForErase: Expense) {
        let request = Expense.createFetchRequest()
        let predicate = NSPredicate(format: "amount = %@", expenseForErase.amount)
        request.predicate = predicate
        do {
            let expenses = try container.viewContext.fetch(request)
            if !expenses.isEmpty {
                for expense in expenses {
                    if expense == expenseForErase {
                        container.viewContext.delete(expense)
                        break
                    }
                }
                self.saveContext()
                dataPresenter?.updateView()
            }
        } catch let error as NSError {
            print("Could not fetch or delete object \(error)")
        }
    }
    
    func editExpense(expenseForEdit: Expense, editedExpense: Expense) {
        
        let request = Expense.createFetchRequest()
        self.deleteExpense(expenseForErase: expenseForEdit)
        
        let expense = Expense(context: self.container.viewContext)
        expense.amount = editedExpense.amount
        expense.category = editedExpense.category
        expense.date = editedExpense.date
        expense.mileage = editedExpense.mileage
        expense.note = editedExpense.note
        expense.vehicle_id = editedExpense.vehicle_id
        
        self.saveContext()
        dataPresenter?.updateView()
    }
}


extension DataManager {
    
    //MARK: Vehicles methods
    
    func getVehiclesCount() -> Int {
        return vehicleResultsController.fetchedObjects?.count ?? 0
    }
    
    func registerNewVehicle(_ name: String,
                       _ mileage: String,
                       _ electric: Bool,
                       _ current: Bool) {
        let newVehicle = Vehicle(context: self.container.viewContext)
        newVehicle.name = name
        newVehicle.vehicle_id = getMaxIdNumber() + 1
        newVehicle.mileage = mileage
        newVehicle.electric = electric
        newVehicle.current = current
        
        self.saveContext()
        dataPresenter?.updateView()
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
                dataPresenter?.updateView()
            }
        } catch let error as NSError {
            print("Could not fetch or delete object \(error)")
        }
    }
}