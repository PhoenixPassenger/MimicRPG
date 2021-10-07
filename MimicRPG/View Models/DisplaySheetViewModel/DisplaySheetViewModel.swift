//
//  DisplaySheetViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/09/21.
//
// swiftlint:disable force_cast

import Foundation

final class DisplaySheetViewModel {
    public weak var output: DisplaySheetViewModelOutput?
    var sheet: Sheet?
}

extension DisplaySheetViewModel: DisplaySheetViewModelType {
    func callEditAttributes() {
        self.output?.displayEditAttributes()
    }

    func getSkills() -> [Skill] {
        return Array(sheet?.skills as! Set<Skill>)
    }
    
    func getPoints() -> [Points] {
        return Array(sheet?.points as! Set<Points>)
    }

    func displayModal() {
        self.output?.displayEditModal()
    }
}
