//
//  DBMatrix+CoreDataProperties.swift
//  App
//
//  Created by User on 19.03.2023.
//
//

import Foundation
import CoreData

extension DBMatrix {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBMatrix> {
        return NSFetchRequest<DBMatrix>(entityName: "DBMatrix")
    }

    @NSManaged public var countCell: Int32
    @NSManaged public var countBomb: Int32
    @NSManaged var field: Field?

}

extension DBMatrix : Identifiable {

}
