//
//  DiceRollerViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//
// swiftlint:disable all

import Foundation
import UIKit

class DiceRollerViewController: UIViewController, DiceRollerViewModelOutput {

    func reloadData() {
        self.tableView.reloadData()
    }

    var viewModel: DiceRollerViewModelType!
    
    weak var coordinator: MainCoordinator?

    let cellReuseIdentifier = "cell"

    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    
    var diceSizes: [Int] = [2, 4, 6, 8, 10, 12, 20, 100]
    var selectedRow = 0
    
    var bonusStepper: UIStepper = UIStepper()

    var tableView = UITableView()
    lazy var rollButton = UIBarButtonItem(title: "Rolar", style: .plain, target: self, action: #selector(rollDices))

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true

        rollButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.josefinSansButton()], for: .normal)

        navigationItem.rightBarButtonItem = rollButton

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        self.view.addSubview(tableView)
        self.tableView.tableFooterView = UIView()

        configureConstraints()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.dices = [Dice(size: 20, quantity: 1)]
        viewModel.bonus = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(named: "Background")
        self.navigationController?.navigationBar.layer.backgroundColor = UIColor(named: "SecondaryBackground")?.cgColor
        rollButton.tintColor = UIColor(named: "Azure")
        tableView.layer.backgroundColor = UIColor(named: "Background")?.cgColor
    }

    @objc func addDices() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.selectRow(selectedRow, inComponent: 0, animated: true)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Escolha o dado", message: "", preferredStyle: .actionSheet)
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            if self.viewModel.dices!.count > 0 {
                var isAdditionalDice: Bool = false
                for dice in self.viewModel.dices! {
                    if dice.size == self.diceSizes[self.selectedRow] {
                        dice.quantity = dice.quantity + 1
                        dice.stepper.value = Double(dice.quantity)
                        isAdditionalDice = true
                    }
                }
                if !isAdditionalDice {
                    self.viewModel.dices!.append(Dice(size: self.diceSizes[self.selectedRow], quantity: 1))
                }
            } else {
                self.viewModel.dices!.append(Dice(size: self.diceSizes[self.selectedRow], quantity: 1))
            }
            
            self.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: { (UIAlertAction) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    @objc func reloadDatas() {
        tableView.reloadData()
    }

    @objc func rollDices() {
        var resultsString: String = ""
        var resultValue: Int = 0

        for dice in viewModel.dices! {
            for _ in 1...dice.quantity {
                let value = Int.random(in: 1...dice.size)
                resultsString += " d\(dice.size)(\(value)) +"
                resultValue += value
            }
        }
        if viewModel.bonus == 0 {
            resultsString.removeLast()
        } else {
            resultsString += " \(viewModel.bonus!)"
        }
        resultValue += viewModel.bonus!

        let alert = UIAlertController(title: "Resultado: \(resultValue)",
                                      message: resultsString,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Confirmar", style: UIAlertAction.Style.default, handler: { _ in
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

extension DiceRollerViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath as IndexPath)
        cell.backgroundColor = UIColor(named: "Background")
        if indexPath.section == 1 {
            cell.accessoryView = viewModel.dices![indexPath.row].stepper
            viewModel.dices![indexPath.row].stepper.addTarget(self, action: #selector(reloadDatas), for: .valueChanged)
            viewModel.dices![indexPath.row].quantity = Int(viewModel.dices![indexPath.row].stepper.value)
            cell.textLabel?.text = "d\(viewModel.dices![indexPath.row].size) (x\(viewModel.dices![indexPath.row].quantity))"
            cell.textLabel?.font = UIFont.josefinSansRegular()
        } else if indexPath.section == 2 {
            cell.accessoryView = bonusStepper
            bonusStepper.addTarget(self, action: #selector(reloadDatas), for: .valueChanged)
            viewModel.bonus! = Int(bonusStepper.value)
            cell.textLabel?.text = "\(viewModel.bonus!)"
        }
        cell.textLabel?.font = UIFont.josefinSansRegular()
        return cell

    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 1 {
            let delete = UIContextualAction(style: .destructive, title: nil) { (contextualAction, view, actionPerformed: (Bool) -> ()) in
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .left)
                self.viewModel.dices!.remove(at: indexPath.row)
                tableView.endUpdates()
            }
            delete.image = UIImage(systemName: "trash")
            return UISwipeActionsConfiguration(actions: [delete])
        } else {
            return UISwipeActionsConfiguration(actions: [])
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 60
        } else {
            return 44
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewModel.viewForHeaderInSection(section: section)
    }
}

extension DiceRollerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = "\(diceSizes[row])"
        label.sizeToFit()
        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        diceSizes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}
