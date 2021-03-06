//
//  DiceRollerViewModelType.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 16/09/21.
//

import Foundation
import UIKit

protocol DiceRollerViewModelType {
    var output: DiceRollerViewModelOutput? {get set}
    var dices: [Dice]? {get set}
    var bonus: Int? {get set}
    var cellReuseIdentifier: String? {get set}
    var screenWidth: CGFloat? {get set}
    var screenHeight: CGFloat? {get set}
    var diceSizes: [Int]? {get set}
    var selectedRow: Int? {get set}
    var bonusStepper: UIStepper? {get set}

    func addDice(pickeredRow: Int)
    func settingValues() -> Bool
    func rollingDices() -> (resultString: String, resultValue: Int)

    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func viewForHeaderInSection(section: Int) -> UIView
    func cellForRowAt(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell
    func trailingSwipeActionsConfigurationForRowAt (indexPath: IndexPath) -> UISwipeActionsConfiguration
    func heightForHeaderInSection (section: Int) -> CGFloat
}
