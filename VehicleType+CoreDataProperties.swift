//
//  VehicleType+CoreDataProperties.swift
//  Autountant
//
//  Created by Sergey on 12/10/23.
//
//

import Foundation
import CoreData


extension VehicleType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VehicleType> {
        return NSFetchRequest<VehicleType>(entityName: "VehicleType")
    }

    @NSManaged public var name: String?
    @NSManaged public var vehicles: Vehicle?

}

extension VehicleType : Identifiable {

}
