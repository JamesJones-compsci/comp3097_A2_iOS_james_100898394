//
//  Product+CoreDataProperties.swift
//  A2_iOS_james_100898394
//
//  Created by Tech on 2026-04-04.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productID: Int64
    @NSManaged public var name: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var price: Double
    @NSManaged public var provider: String?

}

extension Product : Identifiable {

}
