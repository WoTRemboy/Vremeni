//
//  DataController.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 26.07.2024.
//

import Foundation
import CoreData

final class DataController: ObservableObject {
    
    internal let container = NSPersistentContainer(name: "VremeniConsumableModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
