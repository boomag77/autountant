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

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Vehicle> {
        return NSFetchRequest<Vehicle>(entityName: "Vehicle")
    }

    @NSManaged public var name: String
    @NSManaged public var mileage: Int64
    @NSManaged public var active: Bool
    @NSManaged public var units: String
    @NSManaged public var type: String
    @NSManaged public var currency: String

}

extension Vehicle : Identifiable {

}
