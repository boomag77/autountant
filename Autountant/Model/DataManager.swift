//
//  DataManager.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//

import Foundation
import CoreData

protocol DataPresenter: AnyObject {
    var dataManager: DataManager {get set}
    func updateView()
}

class DataManager {
    
    weak var dataPresenter: DataPresenter?
    var container: NSPersistentContainer!
    
    init() {
        container = NSPersistentContainer(name: "Autountant")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    
    
}
