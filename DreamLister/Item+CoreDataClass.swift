//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Paul on 08/07/2017.
//  Copyright © 2017 Technicae. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
        
    }
}
