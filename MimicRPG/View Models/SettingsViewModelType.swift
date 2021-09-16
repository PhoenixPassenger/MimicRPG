//
//  SettingsViewModelType.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 16/09/21.
//

import Foundation
import UIKit
protocol SettingsViewModelType {
    var output: SettingsViewModelOutput? {get set}
    func restartApplication()
    func changeLanguage(language: String)
    func numberOfSections() -> Int
    func viewForHeaderInSection(section: Int) -> UIView
    func cellForRowAt(cell: UITableViewCell) -> UITableViewCell
}
