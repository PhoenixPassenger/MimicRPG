//
//  TableNotes.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/10/21.
//

import Foundation
import UIKit
class TableNotes: UITableView, UITableViewDelegate, UITableViewDataSource {

    var viewModel : DisplayTableViewModelType!

    func setupTableView() {
        self.register(CharacterNotesCell.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = UIColor(named: "Background")
        self.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let colorComponents = UIColor(named: "Background")?.cgColor.components
        if let color = colorComponents {
            view.backgroundColor = UIColor.init(red: color[0], green: color[1], blue: color[2], alpha: 0.75)
        }
        let label = UILabel()
        label.frame = CGRect(x: 15, y: 0, width: 90, height: 30)
        label.text = "Notes".localized()
        label.tintColor = UIColor(named: "FontColor")
        label.font = UIFont.josefinSansRegular()
        view.addSubview(label)

        let button = UIButton(type: .system)
        button.frame = CGRect(x: UIScreen.main.bounds.width * 0.9, y: 0, width: 30, height: 30)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: "Azure")
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
        self.viewModel.newNoteModal()
    }

    private func editCell(row: Int) {
        let notes = self.viewModel.getNotes()
        let noteRow = notes[row]
        self.viewModel.editNoteModal(note: noteRow)
    }

    private func removeCell(row: Int) {
        // Melhor implementar um alert antes disso
        let notes = self.viewModel.getNotes()
        let noteRow = notes[row]
        self.viewModel.removeNote(note: noteRow)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterNotesCell
        guard let cell = cellWrap else { fatalError() }
        let notes = self.viewModel.getNotes()
        let noteRow = notes[indexPath.row]
        cell.set(titleItem: noteRow.name ?? "Nota", valueItem: (noteRow.characteristics?.stringValue) ?? "Descrição")
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNotes().count
    }

    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
