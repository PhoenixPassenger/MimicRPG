//
//  CharacterSkills.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 24/09/21.
//

import Foundation
import UIKit
class CharacterSkills: UITableView, UITableViewDelegate, UITableViewDataSource {
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
        return 3
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
