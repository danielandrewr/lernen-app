//
//  NotificationManager.swift
//  Lernen-App
//
//  Created by Daniel Roong on 29/07/22.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    static let instance = NotificationManager()
    let notificationCenter: UNUserNotificationCenter
    let notificationOptions: UNAuthorizationOptions
    
    var handleNotification: ((UNNotification) -> Void)?
    
    init(handleNotification: ((UNNotification) -> Void)? = nil) {
        self.notificationCenter = UNUserNotificationCenter.current()
        self.notificationOptions = [.alert, .sound, .badge]
        self.handleNotification = handleNotification
    }
    
    func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        notificationCenter.requestAuthorization(options: notificationOptions) { (isAllowed, error) in
            completion(isAllowed, error)
        }
    }
    
    public func scheduleNotification(id: String, content: UNNotificationContent, trigger: UNNotificationTrigger) {
        let requestNotification = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        notificationCenter.add(requestNotification)
    }
    
    public func pathFinishedCreatingNotification(pathName: String) {
        let content = UNMutableNotificationContent()
        content.title = "\(pathName) has been created!"
        content.body = "We will remind you when it is time to get learning 📚"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
                
        self.scheduleNotification(id: UUID().uuidString, content: content, trigger: trigger)
    }
    
    public func createPathReminder(pathName: String, pathDate: Date, minuteInterval: Double) {
        let content = UNMutableNotificationContent()
        content.title = "\(pathName) is starting soon 🔥"
        content.body = "Get yourself ready before hopping in to learning session!"
        content.badge = 1
        content.sound = .default
        
        let triggerDate = pathDate.addingTimeInterval(Double(-(minuteInterval * 60)))
        let calendar = Calendar.current
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: calendar.dateComponents([.timeZone, .year, .month, .day, .hour, .minute, .second],
            from: triggerDate),
            repeats: false
        )
        
        self.scheduleNotification(id: UUID().uuidString, content: content, trigger: trigger)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let handleNotification = handleNotification {
            handleNotification(response.notification)
        }
        completionHandler()
    }
}
