//
//  CharacterSkills.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 24/09/21.
//

import Foundation
import UIKit

class MockSkill {
    var name: String = ""
    var active: Bool = false
    var other: Int = 0
    var modAttribute: Int = 0
    var attribute: String = "CON"
    var levelBy2: Int = 0

    init(name: String, active: Bool, other: Int, modAttribute: Int, attribute: String, levelBy2: Int) {
        self.name = name
        self.active = active
        self.other = other
        self.modAttribute = modAttribute
        self.attribute = attribute
        self.levelBy2 = levelBy2
    }
}

class CharacterSkills: UITableView, UITableViewDelegate, UITableViewDataSource {

    let mockSkills: [MockSkill] = [
        MockSkill(name: "Acrobacia", active: false, other: 0, modAttribute: 1, attribute: "DES", levelBy2: 2),
        MockSkill(name: "Adestramento", active: true, other: 0, modAttribute: 2, attribute: "CAR", levelBy2: 2),
        MockSkill(name: "Atletismo", active: false, other: 2, modAttribute: 1, attribute: "FOR", levelBy2: 2),
        MockSkill(name: "Atuação", active: false, other: 0, modAttribute: 2, attribute: "CAR", levelBy2: 2),
        MockSkill(name: "Cavalgar", active: true, other: 0, modAttribute: 1, attribute: "DES", levelBy2: 2),
        MockSkill(name: "Conhecimento", active: false, other: 0, modAttribute: 1, attribute: "INT", levelBy2: 2),
        MockSkill(name: "Cura", active: false, other: 0, modAttribute: 1, attribute: "SAB", levelBy2: 2)
    ]

    var filteredSkills: [MockSkill] = []

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

    lazy var infoView: CharacterSkillsHeader = {
        let view = CharacterSkillsHeader()
        view.frame = CGRect(x: 0, y: 54, width: UIScreen.main.bounds.width, height: 38)
        return view
    }()

    func setupTableView() {
        self.register(CharacterSkillsCell.self, forCellReuseIdentifier: "MyCell")
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
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterSkillsCell
        guard let cell = cellWrap else { fatalError() }
        cell.set(
            titleItem: filteredSkills[indexPath.row].name,
            active: filteredSkills[indexPath.row].active,
            other: filteredSkills[indexPath.row].other,
            modAttribute: filteredSkills[indexPath.row].modAttribute,
            attribute: filteredSkills[indexPath.row].attribute,
            levelBy2: filteredSkills[indexPath.row].levelBy2)
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

extension CharacterSkills: UISearchBarDelegate {
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

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
}
