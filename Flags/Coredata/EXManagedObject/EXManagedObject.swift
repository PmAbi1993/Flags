//
//  EXManagedObject.swift
//  Api Test
//
//  Created by admin on 03/07/21.
//

import Foundation
import CoreData

public protocol Queryable {
    static var context: NSManagedObjectContext { get }
}

public class EXManagedObject<T: NSManagedObject & Queryable>: EXManagedObjectBluePrint {
    public var queryItemType: T.Type!
    public var context: NSManagedObjectContext
    public var predicates: [NSPredicate] = []
    required public init(_ object: T.Type) {
        self.queryItemType = object
        context = object.context
    }
    public typealias ManagedObject = T

    func filter<Value>(key: KeyPath<T, Value>, option: NSComparisonPredicate.Operator, value: Value) -> Self {
        let lhs: NSExpression = .init(forKeyPath: key)
        let rhs: NSExpression = .init(forConstantValue: value)
        let comparisonPredicate: NSComparisonPredicate = .init(leftExpression: lhs,
                                                               rightExpression: rhs,
                                                               modifier: .direct,
                                                               type: option,
                                                               options: .caseInsensitive)
        self.predicates.append(comparisonPredicate)
        return self
    }
}
