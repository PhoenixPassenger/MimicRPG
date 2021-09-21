//
//  DisplaySheetViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//

import UIKit

class DisplaySheetViewController: UIViewController {
    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor(named: "Background")
    }
}
