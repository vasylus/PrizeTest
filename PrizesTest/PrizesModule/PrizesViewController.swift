//
//  PrizesViewController.swift
//  PrizesTest
//
//  Created by Vasiliy Vasilchenko on 3/22/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import UIKit

final class PrizesViewController: UIViewController {

    var navigation: PrizesWireFrame?
    var interactor: PrizesInteractor?

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var totalSumLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigation = PrizesWireFrame()
        navigation?.prizesViewController = self
        interactor = PrizesInteractor()
        interactor?.tableView = tableView
        interactor?.totalSumLabel = totalSumLabel
    }

    @IBAction private func addNewPrize(_ sender: UIBarButtonItem) {
        navigation?.createNewPrize()
    }

}
