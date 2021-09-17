//
//  DiceRollerViewModelOutput.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 16/09/21.
//

import Foundation
protocol DiceRollerViewModelOutput: AnyObject {

    func addDices()
    func removeDice(indexPath: IndexPath)
    func reloadData()
}
