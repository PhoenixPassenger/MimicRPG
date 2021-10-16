//
//  CharacterAttacksCthulhu.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 15/10/21.
//

import UIKit

class CharacterAttacksCthulhu: UITableView, UITableViewDelegate, UITableViewDataSource {
    var viewModel: DisplaySheetViewModelType!

    func setupTableView() {
        self.register(CharacterAttacksCellCthulhu.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
        self.tableFooterView = UIView()
        self.rowHeight = 155
        self.backgroundColor = UIColor(named: "Background")
    }

    @objc func addCell() {
        viewModel.callAddAttackCthulhu()
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
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterAttacksCellCthulhu
        guard let cell = cellWrap else { fatalError() }
        let attack = self.viewModel.getAttacks()[indexPath.row]
        let attackCharac = attack.characteristics?.allObjects as? [Characteristics]

        var attackDamage = ""
        var attackValue = 0
        var attackAmmo = 0
        var attackRange = ""
        var attackMalfunction = ""
        var attackAttacks = 0
        if let charArr = attackCharac {
            for currentChar in charArr {
                switch (currentChar.name) {
                case AttackCharacteristicsCthulhu.getCharacteristicName(.attackDamage)():
                    attackDamage = currentChar.stringValue ?? ""
                case AttackCharacteristicsCthulhu.getCharacteristicName(.attackValue)():
                    attackValue = Int(currentChar.numberValue)
                case AttackCharacteristicsCthulhu.getCharacteristicName(.attackAmmo)():
                    attackAmmo = Int(currentChar.numberValue)
                case AttackCharacteristicsCthulhu.getCharacteristicName(.attackRange)():
                    attackRange = currentChar.stringValue ?? ""
                case AttackCharacteristicsCthulhu.getCharacteristicName(.attackMalfunction)():
                    attackMalfunction = currentChar.stringValue ?? ""
                case AttackCharacteristicsCthulhu.getCharacteristicName(.attackAttacks)():
                    attackAttacks = Int(currentChar.numberValue)
                default:
                    attackDamage = currentChar.stringValue ?? ""
                }
            }
        }

        cell.set(name: attack.name ?? "", damage: attackDamage, value: attackValue, ammo: attackAmmo, range: attackRange, malfunction: attackMalfunction, attacks: attackAttacks)

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
        self.viewModel.editAttackCthulhuModal(attack: attackRow)
    }
}
