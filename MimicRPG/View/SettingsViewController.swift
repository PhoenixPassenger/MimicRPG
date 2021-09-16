//
//  SettingsViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//

import UIKit
import UserNotifications

class SettingsViewController: UITableViewController, SettingsViewModelOutput {
    weak var coordinator: MainCoordinator?
    var viewModel: SettingsViewModelType!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SettingsViewModel()
        self.viewModel.output = self
        self.view.backgroundColor = UIColor(named: "Background")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.viewModel.changeLanguage(language: "en")
        print(LocalizedStrings.hello.localized)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        return self.viewModel.cellForRowAt(cell: cell)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view  = self.viewModel.viewForHeaderInSection(section: section)
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { _ in
            self.viewModel.restartApplication()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
