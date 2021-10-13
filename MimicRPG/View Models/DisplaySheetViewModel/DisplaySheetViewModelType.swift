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

    func callEditAttributes()
    func getAttributes() -> [Attributes]
    func setAttributes(setSTR: Int, setDEX: Int, setCON: Int, setINT: Int, setWIS: Int, setCHA: Int)
    func callReloadAttributes()
    func callAddAttack()
    func createAttack()
    func getProfile() -> [Characteristics]
    func getSkills() -> [Skill]
    func getPoints() -> [Points]
    func getNotes() -> [Notes]
    func newNote(name: String, text: String)
    func editNote(name: String, text: String, note: Notes)
    func displayModal()
    func newNoteModal()
    func removeNote(note: Notes)
    func editNoteModal(note: Notes)
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
