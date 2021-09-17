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
    var cellReuseIdentifier: String?
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    var diceSizes: [Int]?
    var selectedRow: Int?
    var bonusStepper: UIStepper?
}

extension DiceRollerViewModel: DiceRollerViewModelType {
    
    func rollingDices() -> (resultString: String, resultValue: Int) {
        var resultString: String = ""
        var resultValue: Int = 0

        for dice in dices! {
            for _ in 1...dice.quantity {
                let value = Int.random(in: 1...dice.size)
                resultString += " d\(dice.size)(\(value)) +"
                resultValue += value
            }
        }
        if bonus == 0 {
            resultString.removeLast()
        } else {
            resultString += " \(bonus!)"
        }
        resultValue += bonus!
        
        return (resultString: resultString, resultValue: resultValue)
    }
    
    func addDice(pickeredRow: Int) {
        selectedRow = pickeredRow
        if !dices!.isEmpty {
            var isAdditionalDice: Bool = false
            for dice in dices! {
                if dice.size == diceSizes![selectedRow!] {
                    dice.quantity += 1
                    dice.stepper.value = Double(dice.quantity)
                    isAdditionalDice = true
                }
            }
            if !isAdditionalDice {
                dices!.append(Dice(size: diceSizes![selectedRow!], quantity: 1))
            }
        } else {
            dices!.append(Dice(size: diceSizes![selectedRow!], quantity: 1))
        }
        self.output?.reloadData()
    }

    func heightForHeaderInSection(section: Int) -> CGFloat {
        switch DiceRoller(id: section) {
        case .result:
            return 60
        default:
            return 44
        }
    }

    func trailingSwipeActionsConfigurationForRowAt(indexPath: IndexPath) -> UISwipeActionsConfiguration {
        switch DiceRoller(id: indexPath.section) {
        case .dices:
            let delete = UIContextualAction(style: .destructive, title: nil) { (contextualAction, view, actionPerformed: (Bool) -> ()) in
                self.output?.removeDice(indexPath: indexPath)
            }
            delete.image = UIImage(systemName: "trash")
            return UISwipeActionsConfiguration(actions: [delete])
        default:
            return UISwipeActionsConfiguration(actions: [])
        }
    }

    func cellForRowAt(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell {
        switch DiceRoller(id: indexPath.section) {
        case .result:
            break
        case .dices:
            cell.accessoryView = dices![indexPath.row].stepper
            dices![indexPath.row].stepper.addTarget(self, action: #selector(reloadDataViewModel), for: .valueChanged)
            dices![indexPath.row].quantity = Int(dices![indexPath.row].stepper.value)
            cell.textLabel?.text = "d\(dices![indexPath.row].size) (x\(dices![indexPath.row].quantity))"
            cell.textLabel?.font = UIFont.josefinSansRegular()
        case .bonus:
            cell.accessoryView = bonusStepper
            bonusStepper!.addTarget(self, action: #selector(reloadDataViewModel), for: .valueChanged)
            bonus! = Int(bonusStepper!.value)
            cell.textLabel?.text = "\(bonus!)"
        cell.textLabel?.font = UIFont.josefinSansRegular()
        case .none:
            break
        }
        return cell
    }

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
            button.addTarget(self, action: #selector(addDiceViewModel), for: .touchUpInside)
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

    @objc func addDiceViewModel() {
        self.output?.addDices()
    }

    @objc func reloadDataViewModel() {
        self.output?.reloadData()
    }
}
