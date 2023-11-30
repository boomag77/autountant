//
//  Expense+CoreDataClass.swift
//  Autountant
//
//  Created by Sergey on 11/26/23.
//
//

import Foundation
import CoreData

@objc(Expense)
public class Expense: NSManagedObject {

}

extension Expense {
    static func == (lhs: Expense, rhs: Expense) -> Bool {
        var equals: Bool = false
        if lhs.amount       ==   rhs.amount &&
            lhs.category    ==   rhs.category &&
            lhs.vehicle_id  ==   rhs.vehicle_id &&
            lhs.date        ==   rhs.date &&
            lhs.mileage     ==   rhs.mileage &&
            lhs.note        ==   rhs.note {
            equals = true
        }
        return equals
    }
}
