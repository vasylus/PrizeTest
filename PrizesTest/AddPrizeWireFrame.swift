//
//  AddPrizeWireFrame.swift
//  PrizesTest
//
//  Created by Vasiliy Vasilchenko on 3/22/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import Foundation

protocol AddPrizeWireFrameProtocol {
    func dismissAndInsertPrize(_ prize: Prize)
}

class AddPrizeWireFrame: AddPrizeWireFrameProtocol {

    weak var addPrizeViewController: AddPrizeViewController?

    func dismissAndInsertPrize(_ prize: Prize) {
        addPrizeViewController?.prizesViewController?.interactor?.insertNewPrize(prize)
        addPrizeViewController?.navigationController?.popToRootViewController(animated: true)
    }

}
