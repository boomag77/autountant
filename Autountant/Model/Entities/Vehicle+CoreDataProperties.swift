//
//  Vehicle+CoreDataProperties.swift
//  Autountant
//
//  Created by Sergey on 11/26/23.
//
//

import Foundation
import CoreData


extension Vehicle {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Vehicle> {
        return NSFetchRequest<Vehicle>(entityName: "Vehicle")
    }

    @NSManaged public var mileage: Int64
    @NSManaged public var name: String
    @NSManaged public var current: Bool
    @NSManaged public var type: String

}

extension Vehicle : Identifiable {

}
