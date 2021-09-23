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

    func didSelectRowAt(indexPath: IndexPath) {
        self.initSelectedRow()
        switch Settings(id:indexPath.section) {
        case .language:
            self.output?.showLanguagePicker()
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
            return
        case .none:
            break
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

        cell.backgroundColor = UIColor(named: "SecondaryBackground")
        return cell
    }

    func viewForHeaderInSection(section: Int) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Background")
        let label = UILabel()
        label.text = Settings(id: section)?.description
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "SettingsText")
        label.frame = CGRect(x: 10, y: 10, width: 130, height: 44)
        view.addSubview(label)
        return view
    }

    func changeLanguage(pickeredRow: Int) {
        let language = Languages(id: pickeredRow)
        guard let finalLanguage = language else { return }
        UserDefaults.standard.set([finalLanguage.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        self.output?.showAlert()
    }

    func numberOfSections() -> Int {
        return Settings.allCases.count
    }

    func restartApplication() {
        NotificationService.shared.generateRestartNotification(title: "sim.", body: "test", timeInterval: 0.5)
        fatalError()
    }
}
