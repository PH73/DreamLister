//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Paul on 26/06/2017.
//  Copyright © 2017 Technicae. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
