//
//  NewSheetModalViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 23/09/21.
//

import Foundation
import UIKit

enum Systems: String, CaseIterable {
    case ct7 = "CT7"
    case t20 = "T20"

    var description: String {
        switch self {
        case .ct7:
            return "Cthulhu 7th ed."
        case .t20:
            return "Tormenta 20"
        }
    }

    init?(id : Int) {
        switch id {
        case 0:
            self = .ct7
        case 1:
            self = .t20
        default:
            return nil
        }
    }
}

enum NewSheetModalSettings: CaseIterable {
    case name
    case systems

    var description: String {
        switch self {
        case .name: return "Nome do personagem"
        case .systems: return "Sistema"
        }
    }

    init?(id : Int) {
        switch id {
        case 0:
            self = .name
        case 1:
            self = .systems
        default:
            return nil
        }
    }
}

final class NewSheetModalViewModel {
    var selectedRow: Int? = 0
    var charNameTextField: UITextField?

    public weak var output: NewSheetModalViewModelOutput?
}

extension NewSheetModalViewModel: NewSheetModalViewModelType {

    func initVariables() {
        self.selectedRow = Systems.allCases.firstIndex(of: Systems(rawValue: "CT7")!)
    }

    func changeSystem(pickeredRow: Int) {
        selectedRow = pickeredRow
        self.output?.reloadData()
    }

    func getSystemsDescriptionById(row: Int) -> String {
        let description = Systems(id: row)?.description
        guard let desc = description else { return Systems.ct7.description }
        return desc
    }

    func getNumberOfSystems() -> Int {
        return Systems.allCases.count
    }

    func didSelectRowAt(indexPath: IndexPath) {
        switch NewSheetModalSettings(id:indexPath.section) {
        case .name: break
        case .systems:
            self.output?.showSystemsPicker()
        case .none: break
        }
    }

    func cellForRowAt(cell: UITableViewCell, section: Int) -> UITableViewCell {
        cell.textLabel?.font = .systemFont(ofSize: 17)
        cell.textLabel?.text = ""
        cell.accessoryType = .none
        print(section)
        switch NewSheetModalSettings(id:section) {
        case .name:
            cell.addSubview(charNameTextField!)
        case .systems:
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = Systems(id: selectedRow ?? 0)?.description
        case .none:
            break
        }

        cell.backgroundColor = UIColor(named: "SecondaryBackground")
        return cell
    }

    func viewForHeaderInSection(section: Int) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Background")
        let label = UILabel()
        label.text = NewSheetModalSettings(id: section)?.description
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "SettingsText")
        label.frame = CGRect(x: 10, y: 10, width: 200, height: 44)
        view.addSubview(label)
        return view
    }

    func numberOfSections() -> Int {
        return NewSheetModalSettings.allCases.count
    }
}
