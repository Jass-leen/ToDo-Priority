//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Jasleen on 12/02/24.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var listName: String?
    @NSManaged public var priority: String?

}
