//
//  DBFieldSnapshot+CoreDataProperties.swift
//  App
//
//  Created by User on 19.03.2023.
//
//

import Foundation
import CoreData

extension DBFieldSnapshot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBFieldSnapshot> {
        return NSFetchRequest<DBFieldSnapshot>(entityName: "DBFieldSnapshot")
    }

    @NSManaged var snapshot: Snapshot?

}

extension DBFieldSnapshot : Identifiable {

}
