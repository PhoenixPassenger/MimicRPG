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
        self.tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? CharacterBioCell
        guard let cell = cellWrap else { fatalError() }
        cell.set(titleItem: "Name", valueItem: "Arnaldo")
        return cell
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return self.viewModel.numberOfSections()
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.viewModel.didSelectRowAt(indexPath: indexPath)
//        self.tableView.deselectRow(at: indexPath, animated: true)
//    }

//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view  = self.viewModel.viewForHeaderInSection(section: section)
//        return view
//    }

//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 44
//    }
}
