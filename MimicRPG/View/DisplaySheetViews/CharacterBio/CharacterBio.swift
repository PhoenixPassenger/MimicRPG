//
//  CharacterBio.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 21/09/21.
//

import Foundation
import UIKit

class CharacterBio: UITableView, UITableViewDelegate, UITableViewDataSource {
    var viewModel: DisplaySheetViewModelType!

    func setupTableView() {
        self.register(CharacterBioCell.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = UIColor(named: "Background")
        self.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterBioCell
        guard let cell = cellWrap else { fatalError() }
        let bio = viewModel.getProfile()
        if bio[indexPath.row].name! == "Level" {
            cell.set(titleItem: bio[indexPath.row].name!.localized(), valueItem: "\(bio[indexPath.row].numberValue)")
        } else {
            if let stringValue = bio[indexPath.row].stringValue {
                if (!stringValue.isEmpty) {
                    cell.set(titleItem: bio[indexPath.row].name!.localized(), valueItem: stringValue)
                } else {
                    cell.set(titleItem: bio[indexPath.row].name!.localized(), valueItem: "Empty".localized(), isPlaceholder: true)
                }
                
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProfile().count
    }

    func editCell(row: Int) {
        let profile = self.viewModel.getProfile()
        let profileRow = profile[row]
        self.viewModel.editBioModal(characteristic: profileRow)
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Edit".localized()) { [weak self] (_, _, completionHandler) in
            self?.editCell(row: indexPath.row)
            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }

    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
