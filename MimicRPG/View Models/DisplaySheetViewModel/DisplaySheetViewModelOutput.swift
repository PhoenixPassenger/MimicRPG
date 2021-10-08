//
//  DisplaySheetViewModelOutput.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 21/09/21.
//

import Foundation
protocol DisplaySheetViewModelOutput: AnyObject {
    func displayEditAttributesModal() 
    func displayEditAttributes() 

    func displayEditModal()
//    func addDices()
//    func removeDice(indexPath: IndexPath)
//    func reloadData()
}
