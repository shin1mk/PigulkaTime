//
//  Pigulka+CoreDataProperties.swift
//  
//
//  Created by SHIN MIKHAIL on 22.11.2023.
//
//

import Foundation
import CoreData


extension Pigulka {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pigulka> {
        return NSFetchRequest<Pigulka>(entityName: "Pigulka")
    }

    @NSManaged public var days: String?
    @NSManaged public var dosage: String?
    @NSManaged public var frequency: String?
    @NSManaged public var isEditable: Bool
    @NSManaged public var name: String?
    
    @NSManaged public var times: String?
    @NSManaged public var type: String?
    @NSManaged public var uniqueIdentifier: String?
}
