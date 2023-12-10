//
//  Category+CoreDataProperties.swift
//  Autountant
//
//  Created by Sergey on 12/9/23.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String
    @NSManaged public var expenses: Set<Expense>

}

extension Category : Identifiable {

}
