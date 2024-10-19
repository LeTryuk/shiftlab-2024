//
//  User+CoreDataProperties.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 18.10.2024.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String!

}

extension User : Identifiable {

}
