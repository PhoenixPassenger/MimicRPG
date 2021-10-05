//
//  CharacterAttacks.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 29/09/21.
//

import UIKit

class CharacterAttacks: UITableView, UITableViewDelegate, UITableViewDataSource {

    var attacksCount = 3

    func setupTableView() {
        self.register(CharacterAttacksCell.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
        self.tableFooterView = UIView()
        self.rowHeight = 155
        self.backgroundColor = UIColor(named: "Background")
    }

    @objc func addCell() {
        attacksCount += 1
        self.reloadData()
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
        button.addTarget(self, action: #selector(self.addCell), for: .touchUpInside)

        view.addSubview(button)

        return view
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attacksCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterAttacksCell
        guard let cell = cellWrap else { fatalError() }
        cell.set(name: "Tacape \(indexPath.row)", damage: "1d10", bonus: 3, type: "Corte", reach: "Longo", critical: "x3")
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
            self?.removeCell(row: indexPath.row)
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }

    private func removeCell(row: Int) {
        // Melhor implementar um alert antes disso
        attacksCount -= 1
        let path = IndexPath(row: row, section: 0)
        self.deleteRows(at: [path], with: .fade)
        self.reloadData()
    }

    private func editCell(row: Int) {
        print(row)
    }
}
