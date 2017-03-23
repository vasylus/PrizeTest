//
//  PrizesViewController.swift
//  PrizesTest
//
//  Created by Vasiliy Vasilchenko on 3/22/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import UIKit

class PrizesViewController: UIViewController {

    var navigation: PrizesWireFrame?
    var interactor: PrizesInteractor?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalSumLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigation = PrizesWireFrame()
        navigation?.prizesViewController = self
        interactor = PrizesInteractor()
        interactor?.tableView = tableView
        interactor?.totalSumLabel = totalSumLabel
    }

    @IBAction func addNewPrize(_ sender: UIBarButtonItem) {
        navigation?.createNewPrize()
    }

}
