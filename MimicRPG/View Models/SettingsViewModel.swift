//
//  ViewModel.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 09/09/21.
//

import Foundation
import UserNotifications
import UIKit

enum Settings: CaseIterable {
    case language
    case notifications
    var description: String {
        switch self {
            case .language: return "Language"
            case .notifications: return "Notifications"
        }
    }
    var configurations: Int {
        switch self {
            case .language: return 1
            case .notifications: return 1
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
}
extension SettingsViewModel: SettingsViewModelType {
    func cellForRowAt(cell: UITableViewCell) -> UITableViewCell {
        cell.textLabel?.text = "en"
        cell.textLabel?.font = .systemFont(ofSize: 17)
        cell.accessoryType = .disclosureIndicator
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

    func changeLanguage(language: String) {
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
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
