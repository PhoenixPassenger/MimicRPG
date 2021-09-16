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
//    func restartApplication()
//    func changeLanguage(language: Languages)
    func numberOfSections() -> Int
//    func viewForHeaderInSection(section: Int) -> UIView
//    func cellForRowAt(cell: UITableViewCell, section: Int) -> UITableViewCell
//    func didSelectRowAt(indexPath: IndexPath)
}
