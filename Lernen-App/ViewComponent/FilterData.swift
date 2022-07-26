//
//  FilterData.swift
//  Lernen-App
//
//  Created by Daniel Roong on 26/07/22.
//

import SwiftUI
import CoreData

struct FilterData<Content: View, T>: View where T: NSManagedObject {
    
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    init(datePredicate: Date, @ViewBuilder contentBuilder: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest(entity: T.entity(), sortDescriptors: [], predicate: nil, animation: nil)
        
        self.content = contentBuilder
    }
    
    var body: some View {
        Group {
            if !fetchRequest.isEmpty {
                ForEach(fetchRequest, id: \.objectID) { object in
                    self.content(object)
                }
            } else {
                Text("Yohoo!!! Rest easy, no learning today :)")
                    .padding()
                    .font(.system(size: 18))
                    .offset(y: 100)
            }
        }
    }
}
