//
//  Expense+CoreDataProperties.swift
//  Autountant
//
//  Created by Sergey on 12/9/23.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date
    @NSManaged public var mileage: String
    @NSManaged public var category: Category
    @NSManaged public var vehicle: Vehicle

}

extension Expense : Identifiable {

}
