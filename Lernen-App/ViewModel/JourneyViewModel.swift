//
//  JourneyViewModel.swift
//  Lernen-App
//
//  Created by Daniel Roong on 26/07/22.
//

import SwiftUI

class JourneyViewModel: ObservableObject {
    @Published var activeJourney: Journey?
    @Published var fetchedJourneys: [Journey]?
    
    init() {
        
    }
}
