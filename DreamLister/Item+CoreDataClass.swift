//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Paul on 26/06/2017.
//  Copyright © 2017 Technicae. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        // function is called when item is inserted, and is intended to date stamp the item
        super.awakeFromInsert()
        self.created = NSDate() //NSDate is the current date, that is being assigned to the self.created property - see in the data model, there is an attribute called 'self' of type 'date' - therefore NSDate is being assigned to that attribute
    }
    
}
