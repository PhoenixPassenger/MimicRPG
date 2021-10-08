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
        self.output?.displayEditAttributesModal()
    }

    func getAttributes() -> [Attributes] {
        return Array(sheet?.attribute as! Set<Attributes>)
    }

    func setAttributes(setSTR: Int, setDEX: Int, setCON: Int, setINT: Int, setWIS: Int, setCHA: Int) {
        self.output?.saveSheetAttributes(newSTR: setSTR, newDEX: setDEX, newCON: setCON, newINT: setINT, newWIS: setWIS, newCHA: setCHA)
    }

    func getProfile() -> [Characteristics] {
        return Array(sheet?.profile?.characteristics as! Set<Characteristics>)
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
