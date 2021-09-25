//
//  CharacterSkills.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 24/09/21.
//

import Foundation
import UIKit
class CharacterSkills: UITableView, UITableViewDelegate, UITableViewDataSource {

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 55)
        searchBar.delegate = self
//        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search Here....."
        searchBar.sizeToFit()
        return searchBar
    }()

    lazy var infoView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 55, width: UIScreen.main.bounds.width, height: 41)
        view.backgroundColor = .red
        return view
    }()

    func setupTableView() {
        self.register(CharacterSkillsCell.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
//        self.tableView.separatorStyle = .none
        self.backgroundColor = UIColor(named: "Background")
        self.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterSkillsCell
        guard let cell = cellWrap else { fatalError() }
        cell.set(titleItem: "Nota", active: true)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
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
}

extension CharacterSkills: UISearchBarDelegate {
    
}
