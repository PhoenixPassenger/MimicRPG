//
//  DisplayTableViewModelType.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//
// swiftlint:disable function_parameter_count
// swiftlint:disable line_length

import Foundation
import UIKit

protocol DisplayTableViewModelType {
    var output: DisplayTableViewModelOutput? {get set}
    var table: Table? { get set }
    
    func getNotes() -> [Notes]
    func newNote(name: String, text: String)
    func editNote(name: String, text: String, note: Notes)
    func removeNote(note: Notes)
    func editNoteModal(note: Notes)
    func newNoteModal()
}
