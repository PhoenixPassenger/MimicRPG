//
//  DiceRollerViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 16/09/21.
//

import Foundation
import UIKit

enum DiceRoller: CaseIterable {
    case result
    case dices
    case bonus
//    var description: String {
//        switch self {
//        case .language: return "Language".localized()
//        case .notifications: return "Notifications".localized()
//        }
//    }
//    var configurations: Configurations {
//        switch self {
//        case .language: return .language
//        case .notifications: return .enabled
//        }
//    }
    init?(id : Int) {
        switch id {
        case 0:
            self = .result
        case 1:
            self = .dices
        case 2:
            self = .bonus
        default:
            return nil
        }
    }
}

final class DiceRollerViewModel {
    public weak var output: DiceRollerViewModelOutput?
}

extension DiceRollerViewModel: DiceRollerViewModelType {
    
    func numberOfSections() -> Int {
        return DiceRoller.allCases.count
    }
//
//    func viewForHeaderInSection(section: Int) -> UIView {
//        let view = UIView()
//        return view
//    }
//
//
//    func didSelectRowAt(indexPath: IndexPath) {
//        //
//    }
    
    
}
