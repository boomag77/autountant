//
//  Vehicle+CoreDataProperties.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//
//

import Foundation
import CoreData


extension Vehicle {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Vehicle> {
        return NSFetchRequest<Vehicle>(entityName: "Vehicle")
    }
    @NSManaged public var current: Bool
    @NSManaged public var electric: Bool
    @NSManaged public var name: String
    @NSManaged public var mileage: String
    @NSManaged public var vehicle_id: Int32
}

extension Vehicle : Identifiable {

}
