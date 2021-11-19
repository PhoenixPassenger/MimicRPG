//
//  ViewModel.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 09/09/21.
//

import Foundation
import UserNotifications
import UIKit

enum Languages: String, CaseIterable {
    case english = "en"
    case ptbr = "pt-br"

    var description: String {
        switch self {
        case .english:
            return "English".localized()
        case .ptbr:
            return "Portuguese".localized()
        }
    }

    init?(id : Int) {
        switch id {
        case 0:
            self = .english
        case 1:
            self = .ptbr
        default:
            return nil
        }
    }
}

enum Configurations: CaseIterable {
    case enabled
    case language

    var language: String {
        return UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first ?? "en"
    }

    var description: String? {
        switch self {
        case .enabled: return "Enabled".localized()
        case .language: return Languages(rawValue: (self.language))?.description
        }
    }
}

enum Settings: CaseIterable {
    case language
    case notifications

    var description: String {
        switch self {
        case .language: return "Language".localized()
        case .notifications: return "Notifications".localized()
        }
    }
    var configurations: Configurations {
        switch self {
        case .language: return .language
        case .notifications: return .enabled
        }
    }

    init?(id : Int) {
        switch id {
        case 0:
            self = .language
        case 1:
            self = .notifications
        default:
            return nil
        }
    }
}

final class SettingsViewModel {
    func initSelectedRow() {
        let language = UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first ?? "en"
        self.selectedRow = Languages.allCases.firstIndex(of: Languages(rawValue: language)!)
    }

    public weak var output: SettingsViewModelOutput?
    var selectedRow: Int? = 0

    func switchButton() -> UIView {
        let switchButton = UISwitch()
        switchButton.isOn = false
        switchButton.isEnabled = false
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings(completionHandler: { settings in
            guard (settings.authorizationStatus == .authorized) ||
                    (settings.authorizationStatus == .provisional) else { return }
            DispatchQueue.main.async {
                switchButton.isOn = UserDefaults.standard.bool(forKey: "notificationsEnabled")
                switchButton.isEnabled = true
            }
        })
        switchButton.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchButton
    }

    @objc func handleSwitchAction(sender: UISwitch) {
        let userDefault = UserDefaults.standard
        userDefault.set(sender.isOn, forKey: "notificationsEnabled")
    }

}
extension SettingsViewModel: SettingsViewModelType {

    func getLanguageDescriptionById(row: Int) -> String {
        let description = Languages(id: row)?.description
        guard let desc = description else { return Languages.english.description }
        return desc
    }

    func getNumberOfLanguages() -> Int {
        return Languages.allCases.count
    }

    @discardableResult func didSelectRowAt(indexPath: IndexPath) -> Bool {
        self.initSelectedRow()
        switch Settings(id:indexPath.section) {
        case .language:
            self.output?.showLanguagePicker()
            return true
        case .notifications:
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings(completionHandler: { settings in
                guard (settings.authorizationStatus == .authorized) ||
                        (settings.authorizationStatus == .provisional) else {
                    DispatchQueue.main.async {
                        self.output?.openSettingsAlert()
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.output?.reloadData()
                }
            })
            return true
        case .none:
            return false
        }
    }

    func cellForRowAt(cell: UITableViewCell, section: Int) -> UITableViewCell {
        cell.textLabel?.font = .systemFont(ofSize: 17)
        switch Settings(id:section) {
        case .language:
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = Settings(id: section)?.configurations.description
        case .notifications:
            cell.accessoryView = self.switchButton()
            cell.textLabel?.text = Settings(id: section)?.configurations.description
        case .none:
            break
        }

        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        cell.backgroundColor = UIColor(named: "SecondaryBackground")
        return cell
    }

    func viewForHeaderInSection(section: Int) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Background")
        let label = UILabel()
        label.text = Settings(id: section)?.description
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor(named: "SettingsText")
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            label.widthAnchor.constraint(equalToConstant: 0.7*UIScreen.main.bounds.width),
            label.heightAnchor.constraint(equalToConstant: label.font.lineHeight)
        ])
        return view
    }

    @discardableResult func changeLanguage(pickeredRow: Int) -> Bool {
        let language = Languages(id: pickeredRow)
        guard let finalLanguage = language else { return false }
        UserDefaults.standard.set([finalLanguage.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        self.output?.showAlert()
        return true
    }

    func numberOfSections() -> Int {
        return Settings.allCases.count
    }

    func restartApplication() {
        NotificationService.shared?.generateRestartNotification(title: "RebootLanguageTitle".localized(), body: "RebootLanguageMessage".localized(), timeInterval: 0.5)
        fatalError()
    }
}
