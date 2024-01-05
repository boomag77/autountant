//
//  Expense+CoreDataProperties.swift
//  Autountant
//
//  Created by Sergey on 12/22/23.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var amount: Double
    @NSManaged public var category: String
    @NSManaged public var date: Date
    @NSManaged public var kWatt: Double
    @NSManaged public var mileage: Int64
    @NSManaged public var vehicleName: String
    @NSManaged public var volume: Double

}

extension Expense : Identifiable {

}
