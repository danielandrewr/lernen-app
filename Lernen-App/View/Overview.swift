//
//  Overview.swift
//  Lernen
//
//  Created by Daniel Roong on 25/07/22.
//

import SwiftUI

struct Overview: View {
    
    @StateObject var timeViewModel = TimeViewModel()
    @StateObject var pathViewModel = PathViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 5, pinnedViews: [.sectionHeaders]) {
                Section {
                    CircularProgressBar()
                        .padding()
                } header: {
                    HeaderView()
                }
            }
        }
        
        
    }
    
    func HeaderView() -> some View {
        HStack(alignment: .top, spacing: 5) {
            VStack(alignment: .leading) {
                Text("Overview")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.Primary)
                    .padding(.init(top: 16, leading: 16, bottom: 1, trailing: 0))
                    .leadingHelper()
                
                HStack {
                    Text("Active Journey: ")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(Color.Primary)
                        .padding(.leading)
                        .leadingHelper()
                    
                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                        .font(.system(size: 18))
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                        .padding()
                }
            }
    
        }
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
