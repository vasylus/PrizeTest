//
//  AddPrizeWireFrame.swift
//  PrizesTest
//
//  Created by Vasiliy Vasilchenko on 3/22/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import Foundation

protocol AddPrizeWireFrameProtocol {

    func dismissAndInsertPrize()

    weak var addPrizeViewController: AddPrizeViewController? {set get}

}

final class AddPrizeWireFrame: AddPrizeWireFrameProtocol {

    weak var addPrizeViewController: AddPrizeViewController?

    func dismissAndInsertPrize() {
        addPrizeViewController?.prizesViewController?.interactor?.insertNewPrize()
        addPrizeViewController?.navigationController?.popToRootViewController(animated: true)
    }

}
