//
//  AddNewPath.swift
//  Lernen-App
//
//  Created by Daniel Roong on 26/07/22.
//

import SwiftUI

struct AddNewPath: View {
    
    @Environment(\.dismiss) var dismissModal
    
    var body: some View {
        NavigationView {
            List {
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Create New Path")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Add")
                            .foregroundColor(Color.Tertiary)
                    }
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

struct AddNewPath_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPath()
    }
}
