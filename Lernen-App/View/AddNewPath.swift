//
//  AddNewPath.swift
//  Lernen-App
//
//  Created by Daniel Roong on 26/07/22.
//

import SwiftUI

struct AddNewPath: View {
    
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
                        pathViewModel.addNewPath(pathName: self.pathName, pathDescription: self.pathDescription, pathDate: self.pathDate, notificationEnabled: self.enableNotification)
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
