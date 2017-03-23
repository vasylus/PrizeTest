//
//  PrizesInteractor.swift
//  PrizesTest
//
//  Created by Vasiliy Vasilchenko on 3/22/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import UIKit

protocol PrizesIntercatorProtocol: class {

    func loadData()
    func insertNewPrize(_ prize: Prize)
    func updateSummary()
}

class PrizesInteractor: NSObject, PrizesIntercatorProtocol, UITableViewDataSource, UITableViewDelegate {

    var totalSumLabel: UILabel?
    var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
            loadData()
        }
    }
    var prizes: [Prize]?
    var selectedIndexPaths: [IndexPath] = []

    func loadData() {
        prizes = DataStore.sharedInstance.arrayOfPrizes()
        tableView?.reloadData()
    }

    func insertNewPrize(_ prize: Prize) {
        prizes = DataStore.sharedInstance.arrayOfPrizes()

        let indexPath = IndexPath.init(row: (prizes?.count)! - 1, section: 0)
        tableView?.beginUpdates()
        tableView?.insertRows(at: [indexPath], with: .fade)
        tableView?.endUpdates()

    }

    func updateSummary() {
        var totalSum = 0
        for indexPath in selectedIndexPaths {

            let prize: Prize = prizes![indexPath.row]
            totalSum += Int(prize.price)

            if totalSum > Constants.maxPrice {
                for indexPathToRemove in selectedIndexPaths {

                    let prize: Prize = prizes![indexPathToRemove.row]
                    selectedIndexPaths.removeFirst()
                    totalSum -= Int(prize.price)

                    if totalSum < Constants.maxPrice {
                        totalSumLabel?.text = "Total: \(totalSum)"
                        tableView?.reloadData()
                        return
                    }
                }
            }
        }
        totalSumLabel?.text = "Total: \(totalSum)"
    }

    // MARK: UITableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prizes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrizeCell", for: indexPath)
        let prize: Prize = prizes![indexPath.row]

        if selectedIndexPaths.contains(indexPath) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        cell.textLabel?.text = prize.name
        cell.detailTextLabel?.text = "\(prize.price)"

        return cell
    }

    // MARK: UItableView Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let cell = tableView.cellForRow(at: indexPath) {

            if selectedIndexPaths.contains(indexPath) {
                selectedIndexPaths.remove(at: (selectedIndexPaths.index(of: indexPath))!)
                cell.accessoryType = .none

            } else {
                selectedIndexPaths.append(indexPath)
                cell.accessoryType = .checkmark
            }
            updateSummary()
        }

    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            tableView.beginUpdates()
            DataStore.sharedInstance.deletePrize(prizes?[indexPath.row])
            prizes?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()

        }
    }

}
