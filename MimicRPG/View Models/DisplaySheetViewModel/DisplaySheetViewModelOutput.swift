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
    func displayEditAttributesT20Modal()
    func displayEditAttributesCthulhuModal()
    func displayNewItem()
    func reloadAttributesT20()
    func reloadAttributesCthulhu()
    func reloadPoints()
    func displayEditModal()
    func updateNotes()
    func updateProfile()
    func updateItems()
    func displayEditItemModal(name: String, desc: String, uses: Int, item: Item)
//    func addDices()
//    func removeDice(indexPath: IndexPath)
//    func reloadData()
}
