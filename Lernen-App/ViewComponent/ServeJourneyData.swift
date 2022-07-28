//
//  ServeJourneyData.swift
//  Lernen-App
//
//  Created by Daniel Roong on 28/07/22.
//

import SwiftUI
import CoreData

struct ServeJourneyData<Content: View, T> where T: NSManagedObject {
    
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    var content: (T) -> Content
    
    init(activePredicate: Bool, @ViewBuilder contentBuilder: @escaping (T) -> Content) {
        let format = "isActive == %@"
        let predicate = NSPredicate(format: format, activePredicate)
        
        _fetchRequest = FetchRequest(entity: T.entity(), sortDescriptors: [], predicate: predicate, animation: nil)
        
        self.content = contentBuilder
    }
    
    var body: some View {
        Group {
            if !fetchRequest.isEmpty {
                ForEach(fetchRequest, id: \.objectID) { object in
                    self.content(object)
                }
            } else {
                NoActiveJourneyFound()
            }
        }
    }
    
    func NoActiveJourneyFound() -> some View {
        Text("No Active Journey")
            .font(.headline)
            .foregroundColor(Color.Primary)
            .offset(y: 20)
            .centerHelper()
    }
}
