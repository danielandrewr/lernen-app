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
    
    init() {
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
