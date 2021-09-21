//
//  Service.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 09/09/21.
//
import UserNotifications
import Foundation
class NotificationService {
    var center: UNUserNotificationCenter?

    static var shared: NotificationService = {
        let instance = NotificationService()
        instance.center = UNUserNotificationCenter.current()
        return instance
    }()

    func generateRestartNotification(title: String, body: String, timeInterval: Double) {
        var localUserInfo: [AnyHashable : Any] = [:]
        localUserInfo["pushType"] = "restart"
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.userInfo = localUserInfo
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let identifier = "com.domain.restart"
        let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        self.center?.add(request)
    }
}
