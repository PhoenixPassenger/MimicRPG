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
    
    public var bonus: Int?
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
    func viewForHeaderInSection(section: Int) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SecondaryBackground")
        switch DiceRoller(id: section) {
        case .result:
            view.backgroundColor = UIColor(named: "Background")
            let label = UILabel()
            var rollValue: String = ""
            for dice in dices! {
                rollValue += " \(dice.quantity)d\(dice.size) +"
            }
            if bonus == 0 && !rollValue.isEmpty {
                rollValue.removeLast()
            } else {
                rollValue += " \(bonus!)"
            }
            label.text = rollValue
            label.font = UIFont.josefinSansBold30()
            label.frame = CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 10, height: 44)
            view.addSubview(label)
        case .dices:
            let button = UIButton(type: .custom)
            button.setImage(UIImage(systemName: "plus"), for: .normal)
            button.frame = CGRect(x: UIScreen.main.bounds.width - 50, y: 0, width: 44, height: 44)
            button.tintColor = UIColor(named: "Azure")
            button.addTarget(self, action: #selector(placeholder), for: .touchUpInside)
            view.addSubview(button)
        case .bonus:
            let label = UILabel()
            label.text = "BÔNUS"
            label.font = UIFont.josefinSansSkillDesc()
            label.frame = CGRect(x: 10, y: 10, width: 130, height: 44)
            view.addSubview(label)
        case .none:
            break
        }
        return view
    }
//
//
//    func didSelectRowAt(indexPath: IndexPath) {
//        //
//    }
    
    @objc func placeholder() {
        // aaa
    }
}
