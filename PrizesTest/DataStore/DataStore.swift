//
//  DataStore.swift
//  PrizesTest
//
//  Created by Vasiliy Vasilchenko on 3/22/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import Foundation
import CoreData

final class DataStore: NSObject {

    private var context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)

    static let sharedInstance: DataStore = {
        let instance = DataStore()
        return instance
    }()

    override init() {
        context = CoreDataManager.sharedInstance.managedObjectContext
    }

    func addNewPrize(_ prize: PrizeModel, completion: @escaping (Bool, Error?) -> Void) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Prize", in: context)
        let prizeToSave = Prize(entity:entityDescription!, insertInto: context)

        prizeToSave.setValue(prize.name, forKey: "name")
        prizeToSave.setValue(prize.price, forKey: "price")

        do {
            try context.save()
            completion(true, nil)
        } catch {
            completion(false, error)
            abort()
        }

    }

    func deletePrize(_ prize: Prize?) {
        do {
            context.delete(prize!)
            try context.save()
            print("user deleted!")
        } catch let error {
            print("Could not fetch \(error), \(error._userInfo)")
        }
    }

    func arrayOfPrizes() -> [Prize] {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Prize", in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDescription
        do {
            let result = try context.fetch(fetchRequest)
            if result.count == 0 {
                return []
            } else {
                // swiftlint:disable:next force_cast
                return result as! [Prize]
            }
        } catch let error {
            print("Could not fetch \(error), \(error._userInfo)")
            return []
        }
    }
}
