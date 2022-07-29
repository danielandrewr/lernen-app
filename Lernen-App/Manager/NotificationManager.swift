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
    
    func requestPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        notificationCenter.requestAuthorization(options: options) { handler, error in
            if let error = error {
                print(error.localizedDescription)
                print("Lernen: Failed to authorize notification permission!")
            } else {
                print("Successfully prompted notification permission!")
            }
        }
    }
}
