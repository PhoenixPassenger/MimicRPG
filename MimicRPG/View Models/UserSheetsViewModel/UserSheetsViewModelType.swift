//
//  UserSheetsViewModelType.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 23/09/21.
//

import Foundation
import UIKit
protocol UserSheetsViewModelType {
    var output: UserSheetsViewModelOutput? {get set}
    var sheets: [Sheet]? { get set }

    func fetchSheets() -> [Sheet]
//
//    func initVariables()
//    func changeSystem(pickeredRow: Int)
//    func getSystemsDescriptionById(row: Int) -> String
//    func getNumberOfSystems() -> Int
//    func numberOfSections() -> Int
//    func viewForHeaderInSection(section: Int) -> UIView
//    func cellForRowAt(cell: UITableViewCell, section: Int) -> UITableViewCell
//    func didSelectRowAt(indexPath: IndexPath)
}
