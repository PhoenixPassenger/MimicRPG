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
            return "English"
        case .ptbr:
            return "Português-Brasil"
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
        case .enabled: return "Habilitadas"
        case .language: return Languages(rawValue: (self.language))?.description
        }
    }
}

enum Settings: CaseIterable {
    case language
    case notifications
    var description: String {
        switch self {
        case .language: return "Language"
        case .notifications: return "Notifications"
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
    public weak var output: SettingsViewModelOutput?

    func switchButton() -> UIView {
        let switchButton = UISwitch()
        switchButton.isOn = false
        switchButton.isEnabled = false
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings(completionHandler: { settings in
            guard (settings.authorizationStatus == .authorized) ||
                    (settings.authorizationStatus == .provisional) else { return }
            DispatchQueue.main.async {
                switchButton.isOn = true
                switchButton.isEnabled = true
            }
        })
        switchButton.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchButton
    }

    @objc func handleSwitchAction(sender: UISwitch) {

        if sender.isOn {
            print("habilitado")
        } else {
            print("desabilitado")
        }
    }

}
extension SettingsViewModel: SettingsViewModelType {
    func didSelectRowAt(indexPath: IndexPath) {
        switch Settings(id:indexPath.section) {
        case .language:
            self.changeLanguage(language: .ptbr)
        case .notifications:
            self.output?.openSettingsAlert()
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
        label.textColor = UIColor(hex: "#3C3C4399")
        label.frame = CGRect(x: 10, y: 10, width: 130, height: 44)
        view.addSubview(label)
        return view
    }

    func changeLanguage(language: Languages) {
        UserDefaults.standard.set([language.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        self.output?.showAlert()
    }

    func numberOfSections() -> Int {
        return Settings.allCases.count
    }

    func restartApplication() {
        var localUserInfo: [AnyHashable : Any] = [:]
        localUserInfo["pushType"] = "restart"
        let content = UNMutableNotificationContent()
        content.title = "Configuration Update Complete"
        content.body = "Tap to reopen the application"
        content.sound = UNNotificationSound.default
        content.userInfo = localUserInfo
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let identifier = "com.domain.restart"
        let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request)
        fatalError()
    }
}
