//
//  CoreDataSymbol+CoreDataProperties.swift
//  Portfolio
//
//  Created by Paul Weichhart on 07.06.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataSymbol {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataSymbol> {
        return NSFetchRequest<CoreDataSymbol>(entityName: "CoreDataSymbol")
    }

    @NSManaged public var title: String?
    @NSManaged public var symbol: String?
    @NSManaged public var display: String?
    
    convenience init(networkSymbol: NetworkSymbol, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = networkSymbol.title
        self.symbol = networkSymbol.symbol
        self.display = networkSymbol.display
    }

}
