//
//  DiceRollerViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//
// swiftlint:disable all

import UIKit

class Dice {
    var size: Int = 10
    var quantity: Int = 1
    var stepper: UIStepper = UIStepper()

    init(size: Int, quantity: Int) {
        self.size = size
        self.quantity = quantity
        stepper.value = 1
        stepper.minimumValue = 1
    }
}

class DiceRollerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var coordinator: MainCoordinator?

    let cellReuseIdentifier = "cell"

    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    
    var diceSizes: [Int] = [2, 4, 6, 8, 10, 12, 20, 100]
    var selectedRow = 0
    
    var dices: [Dice] = [Dice(size: 10, quantity: 1)] {
        didSet {
            tableView.reloadData()
        }
    }

    var bonus: Int = 0
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
            if self.dices.count > 0 {
                var isAdditionalDice: Bool = false
                for dice in self.dices {
                    if dice.size == self.diceSizes[self.selectedRow] {
                        dice.quantity = dice.quantity + 1
                        dice.stepper.value = Double(dice.quantity)
                        isAdditionalDice = true
                    }
                }
                if !isAdditionalDice {
                    self.dices.append(Dice(size: self.diceSizes[self.selectedRow], quantity: 1))
                }
            } else {
                self.dices.append(Dice(size: self.diceSizes[self.selectedRow], quantity: 1))
            }
            
            self.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: { (UIAlertAction) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    @objc func reloadData() {
        tableView.reloadData()
    }

    @objc func rollDices() {
        var resultsString: String = ""
        var resultValue: Int = 0

        for dice in dices {
            for _ in 1...dice.quantity {
                let value = Int.random(in: 1...dice.size)
                resultsString += " d\(dice.size)(\(value)) +"
                resultValue += value
            }
        }
        if bonus == 0 {
            resultsString.removeLast()
        } else {
            resultsString += " \(bonus)"
        }
        resultValue += bonus

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

extension DiceRollerViewController {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return dices.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath as IndexPath)
        cell.backgroundColor = UIColor(named: "Background")
        if indexPath.section == 1 {
            cell.accessoryView = dices[indexPath.row].stepper
            dices[indexPath.row].stepper.addTarget(self, action: #selector(reloadData), for: .valueChanged)
            dices[indexPath.row].quantity = Int(dices[indexPath.row].stepper.value)
            cell.textLabel?.text = "d\(dices[indexPath.row].size) (x\(dices[indexPath.row].quantity))"
            cell.textLabel?.font = UIFont.josefinSansRegular()
        } else if indexPath.section == 2 {
            cell.accessoryView = bonusStepper
            bonusStepper.addTarget(self, action: #selector(reloadData), for: .valueChanged)
            bonus = Int(bonusStepper.value)
            cell.textLabel?.text = "\(bonus)"
        }
        cell.textLabel?.font = UIFont.josefinSansRegular()
        return cell

    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 1 {
            let delete = UIContextualAction(style: .destructive, title: nil) { (contextualAction, view, actionPerformed: (Bool) -> ()) in
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .left)
                self.dices.remove(at: indexPath.row)
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
        let view = UIView()
        view.backgroundColor = UIColor(named: "SecondaryBackground")
        if section == 0 {
            view.backgroundColor = UIColor(named: "Background")
            let label = UILabel()
            var rollValue: String = ""
            for dice in dices {
                rollValue += " \(dice.quantity)d\(dice.size) +"
            }
            if bonus == 0 && rollValue.count > 0 {
                rollValue.removeLast()
            } else {
                rollValue += " \(bonus)"
            }
            label.text = rollValue
            label.font = UIFont.josefinSansBold30()
            label.frame = CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 10, height: 44)
            view.addSubview(label)
        } else if section == 1 {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(systemName: "plus"), for: .normal)
            button.frame = CGRect(x: UIScreen.main.bounds.width - 50, y: 0, width: 44, height: 44)
            button.tintColor = UIColor(named: "Azure")
            button.addTarget(self, action: #selector(addDices), for: .touchUpInside)
            view.addSubview(button)
        } else {
            let label = UILabel()
            label.text = "BÔNUS"
            label.font = UIFont.josefinSansSkillDesc()
            label.frame = CGRect(x: 10, y: 10, width: 130, height: 44)
            view.addSubview(label)
        }
        return view
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
