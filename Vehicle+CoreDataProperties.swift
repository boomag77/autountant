//
//  Vehicle+CoreDataProperties.swift
//  Autountant
//
//  Created by Sergey on 12/10/23.
//
//

import Foundation
import CoreData


extension Vehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vehicle> {
        return NSFetchRequest<Vehicle>(entityName: "Vehicle")
    }

    @NSManaged public var active: Bool
    @NSManaged public var mileage: Int64
    @NSManaged public var name: String
    @NSManaged public var units: String
    @NSManaged public var type: String
    @NSManaged public var currency: String
    @NSManaged public var expenses: NSSet?

}

// MARK: Generated accessors for expenses
extension Vehicle {

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: Expense)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: Expense)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}

extension Vehicle : Identifiable {

}
