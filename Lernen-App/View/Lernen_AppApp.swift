//
//  Lernen_AppApp.swift
//  Lernen-App
//
//  Created by Daniel Roong on 26/07/22.
//

import SwiftUI

@main
struct Lernen_AppApp: App {
    let persistenceController = PersistenceController.shared
    private let notificationManager = NotificationManager()
    
    // MARK: Lernen Launch Startup Initialization
    init() {
        // MARK: NotificationCenter delegate
        notificationManager.notificationCenter.delegate = notificationManager
        NotificationManager.instance.requestPermission() { (isAllowed, error) in
            if let error = error {
                print(error.localizedDescription)
                print("Error while attempting to request authorization to user!")
            } else {
                print("Lernen: Authorization request performed!")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
