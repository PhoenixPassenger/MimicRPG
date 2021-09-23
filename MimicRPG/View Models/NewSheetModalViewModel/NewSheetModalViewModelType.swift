//
//  NewSheetModalViewModelType.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 23/09/21.
//

import Foundation
import UIKit
protocol NewSheetModalViewModelType {
    var output: NewSheetModalViewModelOutput? {get set}
    var selectedRow: Int? { get set }

    func getSystemsDescriptionById(row: Int) -> String
    func getNumberOfSystems() -> Int
    func numberOfSections() -> Int
    func viewForHeaderInSection(section: Int) -> UIView
    func cellForRowAt(cell: UITableViewCell, section: Int) -> UITableViewCell
    func didSelectRowAt(indexPath: IndexPath)
}
