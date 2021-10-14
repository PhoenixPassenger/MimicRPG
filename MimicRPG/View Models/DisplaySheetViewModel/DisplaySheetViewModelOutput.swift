//
//  DisplaySheetViewModelOutput.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/09/21.
//

import Foundation
protocol DisplaySheetViewModelOutput: AnyObject {
    func displayEditPointsModal()
    func displayNewNoteModal()
    func displayEditNoteModal(name: String, desc: String, note: Notes)
    func displayEditAttributesModal()
    func displayAddAttackModal()
    func reloadAttributes()
    func reloadPoints()
    func reloadAttacks()
    func displayEditModal()
    func updateNotes()
//    func addDices()
//    func removeDice(indexPath: IndexPath)
//    func reloadData()
}
