//
//  PrizesWireFrame.swift
//  PrizesTest
//
//  Created by Vasiliy Vasilchenko on 3/22/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import UIKit

protocol PrizesWireFrameProtocol {

    func createNewPrize()

}

final class PrizesWireFrame: PrizesWireFrameProtocol {

    weak var prizesViewController: PrizesViewController?

    func createNewPrize() {
        let storyBoard = UIStoryboard.init(name: "AddPrize", bundle: nil)
        if let addNewPrizeViewController = storyBoard.instantiateViewController(
            withIdentifier:"AddPrizeViewController") as? AddPrizeViewController {

            addNewPrizeViewController.prizesViewController = prizesViewController
            prizesViewController?.navigationController?.pushViewController(addNewPrizeViewController, animated: true)
        }
    }

}
