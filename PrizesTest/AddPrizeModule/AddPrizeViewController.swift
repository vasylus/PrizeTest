//
//  AddPrizeViewController.swift
//  PrizesTest
//
//  Created by Vasiliy Vasilchenko on 3/22/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import UIKit

final class AddPrizeViewController: UIViewController {

    var navigation: AddPrizeWireFrame?
    var interactor: AddPrizeInteractor?
    weak var prizesViewController: PrizesViewController?

    let doneButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(add))

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigation = AddPrizeWireFrame()
        navigation?.addPrizeViewController = self
        interactor = AddPrizeInteractor()
        interactor?.addPrizeViewController = self

        navigationItem.rightBarButtonItem = doneButton
        doneButton.isEnabled = false
    }

    func add() {
        interactor?.addNewPrize()
    }

    func updateButtonState() {
        if let interactor = interactor {
            doneButton.isEnabled = interactor.areFieldsFilled()
        }
    }

}
