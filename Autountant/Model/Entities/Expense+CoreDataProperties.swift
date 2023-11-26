//
//  Expense+CoreDataProperties.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var vehicle_id: Int32
    @NSManaged public var date: Date
    @NSManaged public var amount: Double
    @NSManaged public var mileage: String
    @NSManaged public var category: String
    @NSManaged public var note: String

}

extension Expense : Identifiable {

}
