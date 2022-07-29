//
//  AddNewJourney.swift
//  Lernen-App
//
//  Created by Daniel Roong on 29/07/22.
//

import SwiftUI

struct AddNewJourney: View {
    @StateObject var journeyViewModel = JourneyViewModel()
    
    @State var journeyName: String = ""
    @State var journeyDescription: String = ""
    
    var body: some View {
        NavigationView {
            
        }
        .navigationTitle("Create New Journey")
        .navigationBarTitleDisplayMode(.inline)
        .interactiveDismissDisabled()
        .toolbar {
            
        }
    }
}
