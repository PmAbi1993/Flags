//
//  EXManagedBluePrint + CRUD.swift
//  Api Test
//
//  Created by admin on 03/07/21.
//

import CoreData

// MARK: Creating Instance Object
public extension EXManagedObjectBluePrint {
    func create() -> ManagedObject {
        let managedObject: ManagedObject = ManagedObject(context: context)
        return managedObject
    }
    func save() {
        do {
            try self.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: Search / Read Operations
public extension EXManagedObjectBluePrint {
    func search(type: NSCompoundPredicate.LogicalType = .and) -> [ManagedObject]? {
        let fetchrequest: NSFetchRequest<NSFetchRequestResult> = queryItemType.fetchRequest()
        fetchrequest.predicate = NSCompoundPredicate(type: type,
                                                     subpredicates: predicates)
        do {
            return try context.fetch(fetchrequest) as? [ManagedObject]
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: Update Operations
public extension EXManagedObjectBluePrint {
    func update(completion: () -> ([ManagedObject])) {
    }
    @discardableResult
    func editFirstInstance<Value>(_ keypath: WritableKeyPath<ManagedObject, Value>,
                                  value: Value, type: NSCompoundPredicate.LogicalType = .and) -> Bool {
        do {
            guard let searchItems = search(type: type) else { return false }
            guard var firstItem = searchItems.first else { return false }
            firstItem[keyPath: keypath] = value
            try context.save()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
// MARK: Delete Operations
public extension EXManagedObjectBluePrint {
    func delete(type: NSCompoundPredicate.LogicalType = .and) -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = queryItemType.fetchRequest()
        fetchRequest.predicate = NSCompoundPredicate(type: type, subpredicates: predicates)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
            return true
        } catch {
            return false
        }
    }
}
