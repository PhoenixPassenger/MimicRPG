//
//  DisplayTableViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//
// swiftlint:disable force_cast
// swiftlint:disable function_parameter_count
// swiftlint:disable line_length

import Foundation
import UIKit

final class DisplayTableViewModel {
    public weak var output: DisplayTableViewModelOutput?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var sheet: Sheet?
}

extension DisplayTableViewModel: DisplayTableViewModelType {

}

