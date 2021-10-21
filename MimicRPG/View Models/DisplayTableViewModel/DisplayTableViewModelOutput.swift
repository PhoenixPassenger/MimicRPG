//
//  DisplayTableViewModelOutput.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//

import Foundation
protocol DisplayTableViewModelOutput: AnyObject {
    func displayNewNoteModal()
    func displayEditNoteModal(name: String, desc: String, note: Notes)

    func updateNotes()
}
