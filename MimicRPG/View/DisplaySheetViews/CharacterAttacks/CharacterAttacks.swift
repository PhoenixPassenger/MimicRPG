//
//  CharacterAttacks.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 29/09/21.
//

import UIKit

class CharacterAttacks: UITableView, UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        self.register(CharacterAttacksCell.self, forCellReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
        self.tableFooterView = UIView()
        self.rowHeight = 110
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let frame: CGRect = tableView.frame
//
//        let addButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 38))
//        addButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
//        addButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//
//        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 38))
//        headerView.addSubview(addButton)
//        return headerView
//
////        let DoneBut: UIButton = UIButton(frame: CGRectMake(frame.size.width - 200, 0, 150, 50)) //
////        DoneBut.setTitle("Done", forState: .Normal)
////        DoneBut.backgroundColor = UIColor.redColor()
////
////        DoneBut.addTarget(self, action: #selector(ViewController.buttonTapped(_:)), forControlEvents: .TouchUpInside)
////
////        DoneBut.backgroundColor = UIColor.blueColor()
////
////        let headerView: UIView = UIView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
////          headerView.backgroundColor = UIColor.redColor()
////        headerView.addSubview(DoneBut)
////        return headerView
////
////        let button = UIButton()
////        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
////        self.addSubview(button)
////        return button
////
////        let button = AddButtonView()
////        return button
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterAttacksCell
        guard let cell = cellWrap else { fatalError() }
        cell.set()
        cell.layer.cornerRadius = 5
        return cell
    }
}
