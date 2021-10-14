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
    func displayEditBioModal(name: String, desc: String, value: Int, characteristic: Characteristics)
    func displayEditAttributesModal()
    func reloadAttributes()
    func reloadPoints()
    func displayEditModal()
    func updateNotes()
}
