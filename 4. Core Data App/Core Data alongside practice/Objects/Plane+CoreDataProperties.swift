//
//  Plane+CoreDataProperties.swift
//  Core Data alongside practice
//
//  Created by Saman on 03/10/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//
//

import Foundation
import CoreData


extension Plane {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plane> {
        return NSFetchRequest<Plane>(entityName: "Plane")
    }

    @NSManaged public var speed: Int16
    @NSManaged public var destination: String?

}
