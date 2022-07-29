//
//  NotificationManager.swift
//  Lernen-App
//
//  Created by Daniel Roong on 29/07/22.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager()
    let notificationCenter: UNUserNotificationCenter
    let notificationOptions: UNAuthorizationOptions
    
    init() {
        self.notificationCenter = UNUserNotificationCenter.current()
        self.notificationOptions = [.alert, .sound, .badge]
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
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                
        self.scheduleNotification(id: UUID().uuidString, content: content, trigger: trigger)
    }
    
    public func createPathReminder(pathName: String, pathDate: Date, minuteInterval: Double) {
        let content = UNMutableNotificationContent()
        content.title = "\(pathName) is starting soon 🔥"
        content.body = "Get yourself ready before hopping in to learning session!"
        content.badge = 1
        
        let triggerDate = pathDate.addingTimeInterval(Double(-(minuteInterval * 60)))
        let calendar = Calendar.current
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: calendar.dateComponents([.timeZone, .year, .month, .day, .hour, .minute, .second],
            from: triggerDate),
            repeats: false
        )
        
        self.scheduleNotification(id: UUID().uuidString, content: content, trigger: trigger)
    }
}
