//
//  CharacterBio.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 21/09/21.
//

import Foundation
import UIKit
class CharacterBio: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")
        self.setupTableView()
        print(LocalizedStrings.hello.localized)
    }

    func setupTableView() {
        self.tableView.register(CharacterBioCell.self, forCellReuseIdentifier: "MyCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterBioCell
        guard let cell = cellWrap else { fatalError() }
        cell.set(titleItem: "Name", valueItem: "Arnaldo Arnaldo Arnaldo Arnaldo Arnaldo Arnaldo Arnaldo Arnaldo")
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
