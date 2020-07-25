//
//  CoreDataSymbol+CoreDataClass.swift
//  Portfolio
//
//  Created by Paul Weichhart on 07.06.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CoreDataSymbol)
final class CoreDataSymbol: NSManagedObject {
    
    static let entityName = "CoreDataSymbol"
    
    @NSManaged var id: String
    @NSManaged var display: String?
    @NSManaged var title: String?
}

extension CoreDataSymbol {

    convenience init(networkSymbol: NetworkSymbol, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = networkSymbol.symbol
        self.display = networkSymbol.display
        self.title = networkSymbol.title
    }

}
