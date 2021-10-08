//
//  DisplaySheetViewModelOutput.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/09/21.
//

import Foundation
protocol DisplaySheetViewModelOutput: AnyObject {
    func displayEditAttributesModal()
    func displayEditModal()
    func saveSheetAttributes(newSTR: Int, newDEX: Int, newCON: Int, newINT: Int, newWIS: Int, newCHA: Int)
//    func addDices()
//    func removeDice(indexPath: IndexPath)
//    func reloadData()
}
