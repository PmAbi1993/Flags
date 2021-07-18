//
//  EXManagedObjectBP.swift
//  Api Test
//
//  Created by admin on 03/07/21.
//

import CoreData
public protocol EXManagedObjectBluePrint {
    associatedtype ManagedObject: NSManagedObject
    var queryItemType: ManagedObject.Type! { get set }
    var context: NSManagedObjectContext { get set }
    var predicates: [NSPredicate] { get set }
    init(_ object: ManagedObject.Type)
}
