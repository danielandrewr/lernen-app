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
        NotificationManager.instance.requestPermission()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
