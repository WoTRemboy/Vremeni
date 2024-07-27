//
//  Item+CoreDataProperties.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 27.07.2024.
//
//

import Foundation
import CoreData

public class Item: NSManagedObject {}

extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var added: Date?
    @NSManaged public var target: Date?
    @NSManaged public var ready: Bool
    @NSManaged public var started: Date?
    @NSManaged public var price: Int64

}

extension Item : Identifiable {

}
