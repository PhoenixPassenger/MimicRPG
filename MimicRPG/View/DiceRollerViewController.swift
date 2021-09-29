//
//  DiceRollerViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//
// swiftlint:disable all

import Foundation
import UIKit

class DiceRollerViewController: UIViewController {

    var viewModel: DiceRollerViewModelType!
    
    weak var coordinator: MainCoordinator?

    var tableView = UITableView()
    lazy var rollButton = UIBarButtonItem(title: "Roll".localized(), style: .plain, target: self, action: #selector(rollDices))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true

        rollButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.josefinSansButton()], for: .normal)
        navigationItem.rightBarButtonItem = rollButton

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.view.addSubview(tableView)
        self.tableView.tableFooterView = UIView()

        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.settingValues()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(named: "Background")
        self.navigationController?.navigationBar.layer.backgroundColor = UIColor(named: "SecondaryBackground")?.cgColor
        rollButton.tintColor = UIColor(named: "Azure")
        tableView.layer.backgroundColor = UIColor(named: "Background")?.cgColor
    }

    @objc func rollDices() {
        let results = viewModel.rollingDices()
        let alert = UIAlertController(title: "Result".localized() + ": \(results.resultValue)",
                                      message: results.resultString,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Confirm".localized(), style: UIAlertAction.Style.default, handler: { _ in
            }))
        self.present(alert, animated: true, completion: nil)
    }

    func configureConstraints() {
        tableView.contentOffset = CGPoint(x: -18, y: -18)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DiceRollerViewController: DiceRollerViewModelOutput {
    func addDices() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: viewModel.screenWidth!, height: viewModel.screenHeight!/2)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: viewModel.screenWidth!, height: viewModel.screenHeight!))
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.selectRow(viewModel.selectedRow!, inComponent: 0, animated: true)
        
        vc.view.addSubview(pickerView)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor)
        ])
        
        let alert = UIAlertController(title: "ChooseTheDice".localized(), message: "", preferredStyle: .actionSheet)
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Confirm".localized(), style: .default, handler: { (UIAlertAction) in
            self.viewModel.addDice(pickeredRow: pickerView.selectedRow(inComponent: 0))
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .destructive, handler: { (UIAlertAction) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func removeDice(indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .left)
        self.viewModel.dices!.remove(at: indexPath.row)
        tableView.endUpdates()
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension DiceRollerViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.backgroundColor = UIColor(named: "Background")
        return self.viewModel.cellForRowAt(cell: cell, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return self.viewModel.trailingSwipeActionsConfigurationForRowAt(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.viewModel.heightForHeaderInSection(section: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewModel.viewForHeaderInSection(section: section)
    }
}

extension DiceRollerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: viewModel.screenWidth!, height: 30))
        label.text = "\(viewModel.diceSizes![row])"
        label.font = UIFont.josefinSansBold30()
        label.sizeToFit()
        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.diceSizes!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}
