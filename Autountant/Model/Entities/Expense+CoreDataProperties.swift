//
//  Expense+CoreDataProperties.swift
//  Autountant
//
//  Created by Sergey on 11/26/23.
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
    @NSManaged public var mileage: String
    @NSManaged public var note: String
    @NSManaged public var vehicle_id: Int32

}

extension Expense : Identifiable {

}
