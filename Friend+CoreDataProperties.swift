//
//  Friend+CoreDataProperties.swift
//  FriendTime
//
//  Created by Jakob Haglöf on 2017-03-15.
//  Copyright © 2017 Jakob Haglöf. All rights reserved.
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend");
    }

    @NSManaged public var firstName: String?
    @NSManaged public var surName: String?
    @NSManaged public var timeSinceMeet: Double
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension Friend {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: Meeting)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: Meeting)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}
