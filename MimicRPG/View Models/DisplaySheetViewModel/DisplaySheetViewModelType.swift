//
//  DisplaySheetViewModelType.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/09/21.
//

import Foundation
import UIKit

protocol DisplaySheetViewModelType {
    var output: DisplaySheetViewModelOutput? {get set}
    var sheet: Sheet? { get set }
<<<<<<< HEAD
    func callEditAttributes()
    func getSkills() -> [Skill]
=======
    func displayModal()
>>>>>>> main
//    var dices: [Dice]? {get set}
//    var bonus: Int? {get set}
//    var cellReuseIdentifier: String? {get set}
//    var screenWidth: CGFloat? {get set}
//    var screenHeight: CGFloat? {get set}
//    var diceSizes: [Int]? {get set}
//    var selectedRow: Int? {get set}
//    var bonusStepper: UIStepper? {get set}
//
//    func addDice(pickeredRow: Int)
//    func settingValues()
//    func rollingDices() -> (resultString: String, resultValue: Int)
//
//    func numberOfSections() -> Int
//    func numberOfRowsInSection(section: Int) -> Int
//    func viewForHeaderInSection(section: Int) -> UIView
//    func cellForRowAt(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell
//    func trailingSwipeActionsConfigurationForRowAt (indexPath: IndexPath) -> UISwipeActionsConfiguration
//    func heightForHeaderInSection (section: Int) -> CGFloat
}
