//
//  CharacterSkills.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 24/09/21.
//

import Foundation
import UIKit

class CharacterSkillsT20: UITableView, UITableViewDelegate, UITableViewDataSource {
    var viewModel: DisplaySheetViewModelType!

    var filteredSkills: [Skill] = []

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 38)
        searchBar.delegate = self
        searchBar.barTintColor = UIColor(named: "Background")
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "SearchHere".localized()
        searchBar.sizeToFit()
        return searchBar
    }()

    lazy var infoView: CharacterSkillsHeaderT20 = {
        let view = CharacterSkillsHeaderT20()
        view.frame = CGRect(x: 0, y: 54, width: UIScreen.main.bounds.width, height: 38)
        return view
    }()

    func setupTableView() {
        self.register(CharacterSkillsCellT20.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
//        self.tableView.separatorStyle = .none
        self.backgroundColor = UIColor(named: "Background")
        self.tableFooterView = UIView()
        filteredSkills = viewModel.getSkills()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.addGestureRecognizer(tap)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterSkillsCellT20
        guard let cell = cellWrap else { fatalError() }
        cell.set(
            titleItem: filteredSkills[indexPath.row].name!,
            active: filteredSkills[indexPath.row].isActivated,
            other: 0,
            modAttribute: 0,
            attribute: filteredSkills[indexPath.row].attribute!,
            levelBy2: 0
        )
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSkills.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
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

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editSwipe = UIContextualAction(style: .normal, title: nil) { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            print("editar")
        }
        editSwipe.backgroundColor = UIColor(named: "Azure")
        editSwipe.image = UIImage(systemName: "pencil")
        return UISwipeActionsConfiguration(actions: [editSwipe])
    }

    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
}

extension CharacterSkillsT20: UISearchBarDelegate {
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
}
