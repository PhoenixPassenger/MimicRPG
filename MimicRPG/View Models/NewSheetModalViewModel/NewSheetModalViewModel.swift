//
//  NewSheetModalViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 23/09/21.
//
// swiftlint:disable force_cast
import Foundation
import UIKit

enum NewSheetModalSettings: CaseIterable {
    case name
    case systems

    var description: String {
        switch self {
        case .name: return "CharacterName".localized()
        case .systems: return "System".localized()
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

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    public weak var output: NewSheetModalViewModelOutput?
}

extension NewSheetModalViewModel: NewSheetModalViewModelType {

    func createNewSheet(name: String, system: String) {
        let newSheet = Sheet(context: self.context)
        newSheet.name = name
        newSheet.system = system
        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
    }

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
