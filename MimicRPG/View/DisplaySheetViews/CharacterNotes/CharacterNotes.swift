//
//  CharacterNotes.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 23/09/21.
//

import Foundation
import UIKit
class CharacterNotes: UITableView, UITableViewDelegate, UITableViewDataSource {

    var notesCount = 3

    func setupTableView() {
        self.register(CharacterNotesCell.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
//        self.tableView.separatorStyle = .none
        self.backgroundColor = UIColor(named: "Background")
        self.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let colorComponents = UIColor(named: "Background")?.cgColor.components
        if let color = colorComponents {
            view.backgroundColor = UIColor.init(red: color[0], green: color[1], blue: color[2], alpha: 0.75)
        }

        let button = UIButton(type: .system)
        button.frame = CGRect(x: 380, y: 0, width: 30, height: 30)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(self.addCell), for: .touchUpInside)

        view.addSubview(button)

        return view
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "EditNote".localized()) { [weak self] (_, _, completionHandler) in
            self?.editCell(row: indexPath.row)
            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "DeleteNote".localized()) { [weak self] (_, _, completionHandler) in
            self?.removeCell(row: indexPath.row)
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    @objc func addCell() {
        notesCount += 1
        self.reloadData()
    }

    private func editCell(row: Int) {
        print(row)
    }

    private func removeCell(row: Int) {
        // Melhor implementar um alert antes disso
        notesCount -= 1
        let path = IndexPath(row: row, section: 0)
        self.deleteRows(at: [path], with: .fade)
        self.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterNotesCell
        guard let cell = cellWrap else { fatalError() }
        cell.set(titleItem: "Nota", valueItem: "Isso é uma nota curta")
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesCount
    }

    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
