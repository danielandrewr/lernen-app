//
//  AddNewJourney.swift
//  Lernen-App
//
//  Created by Daniel Roong on 29/07/22.
//

import SwiftUI

struct AddNewJourney: View {
    @Environment(\.managedObjectContext) var persistentContainer
    @Environment(\.dismiss) var dismissModal
    
    @StateObject var journeyViewModel = JourneyViewModel()
    
    @State var journeyName: String = ""
    @State var journeyDescription: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Journey Name", text: $journeyName)
                    TextField("What would you like to achieve?", text: $journeyDescription)
                } header: {
                    Text("Journey Information")
                }
            }
        }
        .navigationTitle("Create New Journey")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    let newJourney = Journey(context: persistentContainer)
                    newJourney.journeyId = UUID().uuidString
                    newJourney.journeyName = journeyName
                    newJourney.journeyDescription = journeyDescription
                    newJourney.journeyDate = Date()
                    newJourney.journeyTotalPath = 0
                    newJourney.journeyFinishedPath = 0
                    newJourney.isActive = false
                    
                    do {
                        try persistentContainer.save()
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        print("Lernen: CoreData failed to save to context")
                    }
                } label: {
                    Text("Add")
                        .foregroundColor(Color.Tertiary)
                }
                .disabled(journeyName.isEmpty)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismissModal()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color.Tertiary)
                }
            }
        }
    }
}
