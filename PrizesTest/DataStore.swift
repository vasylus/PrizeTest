//
//  File.swift
//  PrizesTest
//
//  Created by Vasiliy Vasilchenko on 3/22/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import Foundation
import CoreData

class DataStore: NSObject {

    var moc = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)

    class var sharedInstance: DataStore {
        struct Singleton {
            static let instance = DataStore()
        }

        return Singleton.instance
    }

    override init() {
        moc = CoreDataManager.sharedInstance.managedObjectContext
    }

    func addNewPrize(_ prize: Prize, completion: @escaping (Bool, Error?) -> Void) {

        let entityDescription = NSEntityDescription.entity(forEntityName: "Prize", in: moc)
        let prizeToSave = Prize(entity:entityDescription!, insertInto: moc)

        prizeToSave.setValue(prize.name, forKey: "name")
        prizeToSave.setValue(prize.price, forKey: "price")

        do {
            try moc.save()
            completion(true, nil)
        } catch {
            completion(false, error)
            abort()
        }

    }

    func deletePrize(_ prize: Prize?) {

        do {
            moc.delete(prize!)
            try moc.save()
            print("user deleted!")
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    func arrayOfPrizes() -> [Prize] {

        let entityDescription = NSEntityDescription.entity(forEntityName: "Prize", in: moc)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDescription
        do {
            let result = try moc.fetch(fetchRequest)
            if result.count == 0 {
                return []
            } else {
                // swiftlint:disable:next force_cast
                return result as! [Prize]
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return []
        }
    }
}
