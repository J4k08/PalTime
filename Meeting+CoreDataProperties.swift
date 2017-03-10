//
//  Meeting+CoreDataProperties.swift
//  FriendTime
//
//  Created by Jakob Haglöf on 2017-03-10.
//  Copyright © 2017 Jakob Haglöf. All rights reserved.
//

import Foundation
import CoreData


extension Meeting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meeting> {
        return NSFetchRequest<Meeting>(entityName: "Meeting");
    }

    @NSManaged public var type: String?
    @NSManaged public var relationship: Friend?

}
