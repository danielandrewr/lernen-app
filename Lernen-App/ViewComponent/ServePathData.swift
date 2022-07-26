//
//  FilterData.swift
//  Lernen-App
//
//  Created by Daniel Roong on 26/07/22.
//

import SwiftUI
import CoreData

struct ServePathData<Content: View, T>: View where T: NSManagedObject {
    
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
                PathIsEmptyView()
            }
        }
    }
    
    func PathIsEmptyView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            
            Text("Yohoo!!! Rest easy, No Learning Today!")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(Color.Primary)
            
            Text("Or perhaps try clicking the plus button 🤔")
                .font(.system(size: 14))
                .fontWeight(.regular)
                .foregroundColor(Color.Primary)
                .padding(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
        }
        .centerHelper()
    }
}
