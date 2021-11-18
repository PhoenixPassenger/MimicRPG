//
//  CharacterSkillsCthulhu.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 05/10/21.
//

import Foundation
import UIKit

class CharacterSkillsCthulhu: UITableView, UITableViewDelegate, UITableViewDataSource {
    var viewModel: DisplaySheetViewModelType!

    var filteredSkills: [Skill] = []

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 38)
        searchBar.delegate = self
        searchBar.barTintColor = UIColor(named: "Background")
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.showsBookmarkButton = true
        searchBar.placeholder = "SearchHere".localized()
        searchBar.setImage(UIImage(systemName: "plus"), for: UISearchBar.Icon.bookmark, state: .normal)
        searchBar.sizeToFit()
        return searchBar
    }()

    lazy var infoView: CharacterSkillsHeaderCthulhu = {
        let view = CharacterSkillsHeaderCthulhu()
        view.frame = CGRect(x: 0, y: 54, width: UIScreen.main.bounds.width, height: 38)
        return view
    }()

    func setupTableView() {
        self.register(CharacterSkillsCellCthulhu.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = UIColor(named: "Background")
        self.tableFooterView = UIView()
        filteredSkills = viewModel.getSkills()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.addGestureRecognizer(tap)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterSkillsCellCthulhu
        guard let cell = cellWrap else { fatalError() }
        var initialValue = Int(filteredSkills[indexPath.row].initialValue)
        if filteredSkills[indexPath.row].name! == "11_Dodge" {
            let attribute: Attributes = viewModel.getAttributes().first(where: {$0.abbreviation == "DEX"})!
            initialValue = Int(attribute.value)
        } else if filteredSkills[indexPath.row].name! == "23_LanguageOwn" {
            let attribute: Attributes = viewModel.getAttributes().first(where: {$0.abbreviation == "EDU"})!
            initialValue = Int(attribute.value)
        }
        var skillTitle = (filteredSkills[indexPath.row].name!)
        if (filteredSkills[indexPath.row].attribute != "personalized") {
            skillTitle = skillTitle.localized()
        }
        cell.set(
            titleItem: skillTitle,
            active: filteredSkills[indexPath.row].isActivated,
            value: Int(filteredSkills[indexPath.row].value),
            initialValue: initialValue)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSkills.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editSwipe = UIContextualAction(style: .normal, title: "EditSkill".localized()) { (_, _, _: (Bool) -> Void) in
            self.editSkillCell(row: indexPath.row)
        }
        editSwipe.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [editSwipe])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "DeleteSkill".localized()) { [weak self] (_, _, completionHandler) in
            self?.removeSkill(row: indexPath.row)
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        if (filteredSkills[indexPath.row].attribute != "personalized") {
            return UISwipeActionsConfiguration(actions: [])
        } else {
            return UISwipeActionsConfiguration(actions: [action])
        }
    }

    private func removeSkill(row: Int) {
        let skills = self.viewModel.getSkills()
        let skillRow = skills[row]
        self.viewModel.output?.alertDeleteSkill(receivedSkill: skillRow)
    }

    private func editSkillCell(row: Int) {
        let skillCell = self.viewModel.getSkills()
        let skillCellRow = skillCell[row]
        self.viewModel.editSkillsCthulhu(skill: skillCellRow)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.addSubview(searchBar)
        stack.addSubview(infoView)
        return stack
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 96
    }

    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
}

extension CharacterSkillsCthulhu: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredSkills = viewModel.getSkills()
        } else {
            filteredSkills = viewModel.getSkills().filter { item in
                return item.name!.lowercased().contains(searchText.lowercased())
            }
        }
        self.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.createSkillsCthulhu()
       }
}
