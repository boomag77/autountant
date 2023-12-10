//
//  VehicleCurrency+CoreDataProperties.swift
//  Autountant
//
//  Created by Sergey on 12/10/23.
//
//

import Foundation
import CoreData


extension VehicleCurrency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VehicleCurrency> {
        return NSFetchRequest<VehicleCurrency>(entityName: "VehicleCurrency")
    }

    @NSManaged public var name: String?
    @NSManaged public var vehicles: Vehicle?

}

extension VehicleCurrency : Identifiable {

}
