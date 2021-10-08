//
//  DisplaySheetViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/09/21.
//

import Foundation

final class DisplaySheetViewModel {
    public weak var output: DisplaySheetViewModelOutput?
    var sheet: Sheet?
}

extension DisplaySheetViewModel: DisplaySheetViewModelType {
    func callEditAttributes() {
        self.output?.displayEditAttributesModal()
    }
}
