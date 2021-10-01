//
//  CharacterAttacks.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 29/09/21.
//

import UIKit

class CharacterAttacks: UITableView, UITableViewDelegate, UITableViewDataSource {

    lazy var addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        return button
    }()

    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        return view
    }()

    func setupTableView() {
        self.register(CharacterAttacksCell.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
        self.tableFooterView = UIView()
        self.rowHeight = 110
        self.backgroundColor = .purple
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterAttacksCell
        guard let cell = cellWrap else { fatalError() }
        cell.set()
        cell.layer.cornerRadius = 5
        return cell
    }
}
