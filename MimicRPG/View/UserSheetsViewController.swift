//
//  UserSheetsViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//

import UIKit

class UserSheetsViewController: UIViewController {

    weak var coordinator: MainCoordinator?

    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ficha escolhida", for: .normal)
        button.setTitleColor(UIColor(named: "FontColor"), for: .normal)
        self.view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor(named: "Background")

        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

        nextButton.addTarget(self, action: #selector(self.toSheet), for: .touchUpInside)
    }

    @objc func toSheet() {
        coordinator?.goToSelectedSheet(from: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
