//
//  DiceRollerViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 16/09/21.
//

import Foundation
import UIKit

class Dice {
    var size: Int = 10
    var quantity: Int = 1
    var stepper: UIStepper = UIStepper()

    init(size: Int, quantity: Int) {
        self.size = size
        self.quantity = quantity
        stepper.value = 1
        stepper.minimumValue = 1
    }
}

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
    
    public var dices: [Dice]? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.output?.reloadData()
            }
        }
    }
    
//    var dices: [Dice] = [Dice(size: 20, quantity: 1)] {
//        didSet {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.output?.reloadData()
//            }
//        }
//    }

}

extension DiceRollerViewModel: DiceRollerViewModelType {

    func numberOfSections() -> Int {
        return DiceRoller.allCases.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        switch DiceRoller(id: section) {
        case .result:
            return 0
        case .dices:
            return dices?.count ?? 0
        case .bonus:
            return 1
        case .none:
            return 0
        }
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
