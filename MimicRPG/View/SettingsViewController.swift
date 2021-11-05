//
//  SettingsViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//

import UIKit
import UserNotifications

class SettingsViewController: UITableViewController {
    weak var coordinator: MainCoordinator?
    var viewModel: SettingsViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")
        self.setupTableView()
        print(LocalizedStrings.hello.localized)
    }

    func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        return self.viewModel.cellForRowAt(cell: cell, section: indexPath.section)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectRowAt(indexPath: indexPath)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view  = self.viewModel.viewForHeaderInSection(section: section)
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    override func viewWillAppear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "SecondaryBackground")
        appearance.titleTextAttributes = [.font:
        UIFont.boldSystemFont(ofSize: 20.0),
                                      .foregroundColor: UIColor(named: "FontColor") as Any]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(named: "FontColor")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension SettingsViewController: SettingsViewModelOutput {
    func showLanguagePicker() {
        let viewController = UIViewController()
        let screenWidth = UIScreen.main.bounds.width - 10
        let screenHeight = UIScreen.main.bounds.height / 2
        viewController.preferredContentSize = CGSize(width: screenWidth, height: screenHeight/2)

        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.delegate = self
        pickerView.dataSource = self

        pickerView.selectRow(viewModel.selectedRow!, inComponent: 0, animated: true)

        viewController.view.addSubview(pickerView)

        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        ])

        let alert = UIAlertController(title: "titleAlert".localized(), message: "", preferredStyle: .actionSheet)
        alert.setValue(viewController, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Confirm".localized(), style: .default, handler: { _ in
            self.viewModel.changeLanguage(pickeredRow: pickerView.selectedRow(inComponent: 0))
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .destructive, handler: { _ in
        }))

        self.present(alert, animated: true, completion: nil)
    }

    func reloadData() {
        self.tableView.reloadData()
    }

    func openSettingsAlert() {
        let alertController = UIAlertController(title: "TitleSettingsAlert".localized(), message: "GoToSettingsMessage".localized(), preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "GoToSettingsButton".localized(), style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    switch success {
                    case true:
                        return
                    case false:
                        return
                    }
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .default, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func showAlert() {
        let alert = UIAlertController(title: "AlertSettingsChanged".localized(), message: "MessageAlertSettingsChanged".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reboot".localized(), style: UIAlertAction.Style.default, handler: { _ in
            self.viewModel.restartApplication()
        }))
        alert.addAction(UIAlertAction(title: "ContinueUsing".localized(), style: UIAlertAction.Style.cancel, handler: { _ in
            self.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let screenWidth = UIScreen.main.bounds.width - 10
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = self.viewModel.getLanguageDescriptionById(row: row)
        label.font = .systemFont(ofSize: 17)
        label.sizeToFit()
        return label
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.getNumberOfLanguages()
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}
