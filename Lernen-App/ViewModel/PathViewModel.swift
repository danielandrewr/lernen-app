//
//  PathViewModel.swift
//  Lernen-App
//
//  Created by Daniel Roong on 26/07/22.
//

import SwiftUI

class PathViewModel: ObservableObject {
    
    @Published var todaysPath: [Path]?
    
    init() {
//        filterTodaysPaths()
    }
    
    public func isPathInCurrentHour(date: Date) -> Bool {
        let getHour = Calendar.current.component(.hour, from: date)
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        return getHour == currentHour
    }

}
