//
//  HideKeyboard.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 30/09/21.
//

import Foundation

import UIKit

extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissingKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissingKeyboard() {
        view.endEditing(true)
    }
}
