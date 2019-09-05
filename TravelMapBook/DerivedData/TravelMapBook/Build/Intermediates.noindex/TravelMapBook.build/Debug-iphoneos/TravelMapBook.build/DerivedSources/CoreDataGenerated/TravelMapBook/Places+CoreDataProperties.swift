//
//  Places+CoreDataProperties.swift
//  
//
//  Created by calzom on 5.09.2019.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Places {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Places> {
        return NSFetchRequest<Places>(entityName: "Places")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?

}
