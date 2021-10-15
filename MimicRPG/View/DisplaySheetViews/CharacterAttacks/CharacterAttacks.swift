//
//  CharacterAttacks.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 29/09/21.
//

import UIKit

class CharacterAttacks: UITableView, UITableViewDelegate, UITableViewDataSource {
    var viewModel: DisplaySheetViewModelType!

    func setupTableView() {
        self.register(CharacterAttacksCell.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
        self.tableFooterView = UIView()
        self.rowHeight = 155
        self.backgroundColor = UIColor(named: "Background")
    }

    @objc func addCell() {
        viewModel.callAddAttack()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let colorComponents = UIColor(named: "Background")?.cgColor.components
        if let color = colorComponents {
            view.backgroundColor = UIColor.init(red: color[0], green: color[1], blue: color[2], alpha: 0.75)
        }

        let button = UIButton(type: .system)
        button.frame = CGRect(x: UIScreen.main.bounds.width * 0.9, y: 0, width: 30, height: 30)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: "Azure")
        button.addTarget(self, action: #selector(self.addCell), for: .touchUpInside)

        view.addSubview(button)

        return view
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getAttacks().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterAttacksCell
        guard let cell = cellWrap else { fatalError() }
        let attack = self.viewModel.getAttacks()[indexPath.row]
        let attackCharac = attack.characteristics?.allObjects as? [Characteristics]

        var attackDamage = ""
        var attackBonus = 0
        var attackType = ""
        var attackReach = ""
        var attackCritical = ""
        if let charArr = attackCharac {
            for currentChar in charArr {
                switch (currentChar.name) {
                case AttackCharacteristicsT20.getCharacteristicName(.attackDamage)():
                    attackDamage = currentChar.stringValue ?? ""
                case AttackCharacteristicsT20.getCharacteristicName(.attackBonus)():
                    attackBonus = Int(currentChar.numberValue)
                case AttackCharacteristicsT20.getCharacteristicName(.attackType)():
                    attackType = currentChar.stringValue ?? ""
                case AttackCharacteristicsT20.getCharacteristicName(.attackReach)():
                    attackReach = currentChar.stringValue ?? ""
                case AttackCharacteristicsT20.getCharacteristicName(.attackCritical)():
                    attackCritical = currentChar.stringValue ?? ""
                default:
                    attackDamage = currentChar.stringValue ?? ""
                }
            }
        }

        cell.set(name: attack.name ?? "", damage: attackDamage, bonus: attackBonus, type: attackType, reach: attackReach, critical: attackCritical)

        cell.contentView.isUserInteractionEnabled = false
        return cell
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "EditAttack".localized()) { [weak self] (_, _, completionHandler) in
            self?.editCell(row: indexPath.row)
            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "DeleteAttack".localized()) { [weak self] (_, _, completionHandler) in
            self?.removeAttack(row: indexPath.row)
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }

    private func removeAttack(row: Int) {
        // Melhor implementar um alert antes disso
        let attacks = self.viewModel.getAttacks()
        let attackRow = attacks[row]
        self.viewModel.removeAttack(attack: attackRow)
    }

    private func editCell(row: Int) {
        let attacks = self.viewModel.getAttacks()
        let attackRow = attacks[row]
        self.viewModel.editAttackModal(attack: attackRow)
    }
}
