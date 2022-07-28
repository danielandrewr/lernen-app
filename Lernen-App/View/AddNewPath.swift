//
//  AddNewPath.swift
//  Lernen-App
//
//  Created by Daniel Roong on 26/07/22.
//

import SwiftUI

struct AddNewPath: View {
    
    @Environment(\.managedObjectContext) var persistentContainer
    @Environment(\.dismiss) var dismissModal
    
    @StateObject var pathViewModel = PathViewModel()
    
    @State var pathName: String = ""
    @State var pathDescription: String = ""
    @State var pathDate: Date = Date()
    @State var enableNotification: Bool = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Ex: RxSwift", text: $pathName)
                    TextField("Learn more about RxSwift", text: $pathDescription)

                } header: {
                    Text("Path Information")
                }
                
                Section {
                    Text("\(pathDate, formatter: dateFormatter)")
                    VStack() {
                        DatePicker("", selection: $pathDate, displayedComponents: [.date, .hourAndMinute])
                            .labelsHidden()
                    }
                } header: {
                    Text("Path Date")
                }
                
                Section {
                    Toggle("Enable Notification", isOn: $enableNotification)
                } header: {
                    Text("Advanced")
                } footer: {
                    Text("If enabled, Lernen will remind you when it is time to start learning by pushing a notification")
                }
            }
            .navigationTitle("Create New Path")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newPath = Path(context: persistentContainer)
                        newPath.pathId = UUID().uuidString
                        newPath.pathName = pathName
                        newPath.pathDescription = pathDescription
                        newPath.pathDate = pathDate
                        newPath.isFinished = false
                        newPath.notificationEnabled = enableNotification

                        do {
                            try persistentContainer.save()
                        } catch let error as NSError {
                            print(error.localizedDescription)
                            print("Lernen: Failed to save to context")
                        }
                        
                        dismissModal()
                    } label: {
                        Text("Add")
                            .foregroundColor(Color.Tertiary)
                    }
                    .disabled(pathName.isEmpty)
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
}
