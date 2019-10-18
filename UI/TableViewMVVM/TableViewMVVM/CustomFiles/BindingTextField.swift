//
//  BindingTextField.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/15.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation
import UIKit

class BindingTextField : UITextField {

    var textChanged :(String) -> Void = { _ in }

    func bind(callback :@escaping (String) -> Void) {

        self.textChanged = callback
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField :UITextField) {

        self.textChanged(textField.text!)
    }

}
