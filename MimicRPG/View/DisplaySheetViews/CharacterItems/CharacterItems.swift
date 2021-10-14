//
//  CharacterItems.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 23/09/21.
//

import Foundation
import UIKit
class CharacterItems: UITableView, UITableViewDelegate, UITableViewDataSource {
    var viewModel: DisplaySheetViewModelType!
    func setupTableView() {
        self.register(CharacterItemsCell.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
        self.rowHeight = 125
        self.backgroundColor = UIColor(named: "Background")
        self.separatorStyle = .none
        self.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterItemsCell
        guard let cell = cellWrap else { fatalError() }
        let item = self.viewModel.getItems()[indexPath.row]
        guard let itemUses = item.characteristics?.numberValue else {
            fatalError()
        }
        cell.set(itemName: item.name ?? "", itemDescription: item.characteristics?.stringValue ?? "", itemUses: Int(itemUses))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deselectRow(at: indexPath, animated: false)
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

    @objc func addCell() {
        self.viewModel.newItemModal()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.getItemsCount()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "EditItem".localized()) { [weak self] (_, _, completionHandler) in
            self?.editCell(row: indexPath.row)
            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "DeleteItem".localized()) { [weak self] (_, _, completionHandler) in
            self?.removeCell(row: indexPath.row)
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }

    private func removeCell(row: Int) {
        // Melhor implementar um alert antes disso
        let items = self.viewModel.getItems()
        let itemRow = items[row]
        self.viewModel.removeItem(item: itemRow)
    }

    private func editCell(row: Int) {
        let items = self.viewModel.getItems()
        let itemRow = items[row]
        self.viewModel.editItemModal(item: itemRow)
    }
}
