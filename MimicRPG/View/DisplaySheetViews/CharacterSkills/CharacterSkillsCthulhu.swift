//
//  CharacterSkillsCthulhu.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 05/10/21.
//

import Foundation
import UIKit

class MockSkillCthulhu {
    var name: String = ""
    var active: Bool = false
    var value: Int = 0

    init(name: String, active: Bool, value: Int) {
        self.name = name
        self.active = active
        self.value = value
    }
}

class CharacterSkillsCthulhu: UITableView, UITableViewDelegate, UITableViewDataSource {

    let mockSkills: [MockSkillCthulhu] = [
        MockSkillCthulhu(name: "Antropologia", active: true, value: 22),
        MockSkillCthulhu(name: "Arqueologia", active: false, value: 22),
        MockSkillCthulhu(name: "Arremessar", active: true, value: 25),
        MockSkillCthulhu(name: "Artes Marciais", active: false, value: 22),
        MockSkillCthulhu(name: "Astrologia", active: false, value: 22),
    ]

    var filteredSkills: [MockSkillCthulhu] = []

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
        self.register(CharacterSkillsCellCthulhu.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
//        self.tableView.separatorStyle = .none
        self.backgroundColor = UIColor(named: "Background")
        self.tableFooterView = UIView()
        filteredSkills = mockSkills

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.addGestureRecognizer(tap)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterSkillsCellCthulhu
        guard let cell = cellWrap else { fatalError() }
        cell.set(
            titleItem: filteredSkills[indexPath.row].name,
            active: filteredSkills[indexPath.row].active,
            value: filteredSkills[indexPath.row].value)
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

extension CharacterSkillsCthulhu: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredSkills = mockSkills
        } else {
            filteredSkills = mockSkills.filter { item in
                return item.name.lowercased().contains(searchText.lowercased())
            }
        }
        self.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
}

