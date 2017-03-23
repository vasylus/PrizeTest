//
//  AddPrizeInteractor.swift
//  PrizesTest
//
//  Created by Vasiliy Vasilchenko on 3/22/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import UIKit

protocol AddPrizeInteractorProtocol {
    func addNewPrize()
}

final class AddPrizeInteractor: NSObject {

    weak var addPrizeViewController: AddPrizeViewController? {
        didSet {
            addPrizeViewController?.nameField.delegate = self
            addPrizeViewController?.priceField.delegate = self

            addPrizeViewController?.priceField.addTarget(
                self,
                action: #selector(textFieldDidChange(_:)),
                for: .editingChanged
            )
            addPrizeViewController?.nameField.addTarget(
                self,
                action: #selector(textFieldDidChange(_:)),
                for: .editingChanged
            )

        }
    }

    func areFieldsFilled() -> Bool {
        if (addPrizeViewController?.nameField.text?.characters.count)! > 0 &&
            (addPrizeViewController?.priceField.text?.characters.count)! > 0 {
            return true

        } else {
            return false
        }
    }

}

extension AddPrizeInteractor: AddPrizeInteractorProtocol {

    func addNewPrize() {
        let prize = PrizeModel()
        prize.name = addPrizeViewController?.nameField.text!
        prize.price = Int((addPrizeViewController?.priceField.text)!)

        DataStore.sharedInstance.addNewPrize(prize) { [weak self]  contextDidSave, _ in
            if contextDidSave {
                self?.addPrizeViewController?.navigation?.dismissAndInsertPrize()
            }
        }
    }

}

extension AddPrizeInteractor: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == addPrizeViewController?.priceField {
        guard let price = Int(NSString(string: textField.text!).replacingCharacters(in: range, with: string)),
            price > Constants.maxPrice else { return true }
        return false
        } else {
            return true
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == addPrizeViewController?.nameField {
            addPrizeViewController?.priceField.becomeFirstResponder()
        } else {
            addPrizeViewController?.updateButtonState()
        }
        return true
    }

    func textFieldDidChange(_ textField: UITextField) {
        addPrizeViewController?.updateButtonState()
    }

}
