//
//  PathViewModel.swift
//  Lernen-App
//
//  Created by Daniel Roong on 26/07/22.
//

import SwiftUI

class PathViewModel: ObservableObject {
    
    @Published var todaysPath: [Path]?
    
    @Published var addNewPath: Bool = false
    
    @Environment(\.managedObjectContext) var persistentContainer
    
    init() {
//        filterTodaysPaths()
    }
    
    public func isPathInCurrentHour(date: Date) -> Bool {
        let getHour = Calendar.current.component(.hour, from: date)
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        return getHour == currentHour
    }
    
    public func addNewPath(pathName: String, pathDescription: String, pathDate: Date, notificationEnabled: Bool) {
        let newPath = Path(context: persistentContainer)
        newPath.pathId = UUID().uuidString
        newPath.pathName = pathName
        newPath.pathDescription = pathDescription
        newPath.pathDate = pathDate
        newPath.isFinished = false
        saveToContext()
    }
    
    public func saveToContext() {
        do {
            try persistentContainer.save()
        } catch let error as NSError {
            print(error.localizedDescription)
            print("Lernen: Failed to save to context!")
        }
    }
}
