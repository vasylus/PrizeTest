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

class AddPrizeInteractor: NSObject, AddPrizeInteractorProtocol, UITextFieldDelegate {

    weak var addPrizeViewController: AddPrizeViewController? {
        didSet {
            addPrizeViewController?.nameTextField.delegate = self
            addPrizeViewController?.priceTextField.delegate = self

            addPrizeViewController?.priceTextField.addTarget(self, action: #selector(textFieldDidChange),
                                                             for: .editingChanged)
            addPrizeViewController?.nameTextField.addTarget(self, action: #selector(textFieldDidChange),
                                                            for: .editingChanged)

        }
    }

    func addNewPrize() {
        let prize = Prize()
        prize.name = addPrizeViewController?.nameTextField.text ?? "Prize"
        prize.price = Int16((addPrizeViewController?.priceTextField.text)!) ?? 0

        DataStore.sharedInstance.addNewPrize(prize) { [unowned self]  contextDidSave, _ in
            if contextDidSave {
                self.addPrizeViewController?.navigation?.dismissAndInsertPrize(prize)
            }
        }
    }

    func fieldsFilled() -> Bool {
        if (addPrizeViewController?.nameTextField.text?.characters.count)! > 0 &&
            (addPrizeViewController?.priceTextField.text?.characters.count)! > 0 {
            return true

        } else {
            return false
        }
    }

    // MARK: TextField Delegate

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        if textField == addPrizeViewController?.priceTextField {

            if let price = Int(NSString(string: textField.text!).replacingCharacters(in: range, with: string)) {
                if  price > Constants.maxPrice {
                    return false
                } else {
                    return true
                }
            } else {
                return true
            }
        } else {
            return true
        }

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == addPrizeViewController?.nameTextField {
            addPrizeViewController?.priceTextField.becomeFirstResponder()
        } else {
            if fieldsFilled() {
                addNewPrize()
            }
        }
        return true
    }

    func textFieldDidChange(_ textField: UITextField) {
        if fieldsFilled() {
            addPrizeViewController?.doneButton.isEnabled = true
        } else {
            addPrizeViewController?.doneButton.isEnabled = false

        }
    }

}
