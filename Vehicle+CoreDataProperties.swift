//
//  Vehicle+CoreDataProperties.swift
//  Autountant
//
//  Created by Sergey on 12/9/23.
//
//

import Foundation
import CoreData


extension Vehicle {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Vehicle> {
        return NSFetchRequest<Vehicle>(entityName: "Vehicle")
    }

    @NSManaged public var currency: String
    @NSManaged public var active: Bool
    @NSManaged public var mileage: String
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var units: String
    @NSManaged public var expenses: Set<Expense>

}

extension Vehicle : Identifiable {

}
