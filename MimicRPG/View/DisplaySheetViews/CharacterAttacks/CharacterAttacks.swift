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
        self.rowHeight = 120
    }

    @objc func addCell() {
        attacksCount += 1
        self.reloadData()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(hue: 1, saturation: 0, brightness: 1, alpha: 0.75)

        let button = UIButton(type: .system)
        button.frame = CGRect(x: 380, y: 0, width: 30, height: 30)
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
        cell.set(name: "Tacape \(indexPath.row)")
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(removeCell), for: .touchUpInside)
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editCell), for: .touchUpInside)
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }

    @objc func removeCell(sender: UIButton) {
        attacksCount -= 1
        let path = IndexPath(row: sender.tag, section: 0)
        self.deleteRows(at: [path], with: .fade)
        self.reloadData()
    }

    @objc func editCell() {

    }
}
