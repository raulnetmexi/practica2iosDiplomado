//
//  DrinkCoreData+CoreDataProperties.swift
//  Barman
//
//  Created by raul.oropeza on 04/03/23.
//
//

import Foundation
import CoreData


extension DrinkCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DrinkCoreData> {
        return NSFetchRequest<DrinkCoreData>(entityName: "DrinkCoreData")
    }

    @NSManaged public var directions: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var name: String?
    @NSManaged public var img: String?

}

extension DrinkCoreData : Identifiable {

}
