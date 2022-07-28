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
    
    @State var activeJourney: String = "RxSwift"
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
                Section {
                    CircularProgressBar()
                        .padding()
                } header: {
                    HeaderView()
                }
                
                VStack(spacing: 10) {
                    
                }
            }
            
            LazyVStack(spacing: 25) {
                Section {
                    Text("Next Journey")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(Color.Primary)
                        .leadingHelper()
                        .padding()
                }
            }
            .leadingHelper()
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    func HeaderView() -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Overview")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color.Primary)
                
                HStack {
                    Text("Active Journey: \(activeJourney)")    .leadingHelper()
                    
                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                        .foregroundColor(Color.gray)
                        .padding(.bottom)
                        .trailingHelper()
                }
            }
            .leadingHelper()
        }
        .padding()
        .padding(.top, safeAreaBounds().top)
        .background(Color.white)
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
