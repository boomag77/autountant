//
//  ExpenseCategory+CoreDataProperties.swift
//  Autountant
//
//  Created by Sergey on 12/10/23.
//
//

import Foundation
import CoreData


extension ExpenseCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseCategory> {
        return NSFetchRequest<ExpenseCategory>(entityName: "ExpenseCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var expenses: Expense?

}

extension ExpenseCategory : Identifiable {

}
