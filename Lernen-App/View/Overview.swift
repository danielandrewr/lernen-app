//
//  Overview.swift
//  Lernen
//
//  Created by Daniel Roong on 25/07/22.
//

import SwiftUI

struct Overview: View {
    
    @StateObject var journeyViewModel = JourneyViewModel()
    @StateObject var timeViewModel = TimeViewModel()
    @StateObject var pathViewModel = PathViewModel()
    
    var progress: Float {
        guard let finishedPath = journeyViewModel.activeJourney?.journeyFinishedPath else { return 1 }
        guard let totalPath = journeyViewModel.activeJourney?.journeyTotalPath else { return 1 }
        return Float(finishedPath / totalPath)
    }
    
    @State var activeJourney: String = "RxSwift"
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
                Section {
                    CircularProgressBar(progress: self.progress)
                        .padding()
                } header: {
                    HeaderView()
                }
                
                ActiveJourneyView()
            }
            
            LazyVStack(spacing: 25) {
                Section {
                    Text("Next Journey")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(Color.Primary)
                        .leadingHelper()
                        .padding()
                }
                
                InactiveJourneyView()
            }
            .leadingHelper()
        }
        .ignoresSafeArea(.container, edges: .top)
        .overlay(
            Button(action: {
                self.journeyViewModel.addNewJourney.toggle()
            }, label: {
                Image(systemName: "plus")
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(width: 50, height: 50)
                    .background(
                        Color.black,
                        in: Circle()
                    )
                    .offset(x: -5, y: -10)
            })
            .padding(),
            alignment: .bottomTrailing
        )
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
    
    // MARK: ActiveJourney View
    func ActiveJourneyView() -> some View {
        LazyVStack(spacing: 10) {
            ServeJourneyData(activePredicate: true) { (object: Journey) in
                JourneyCard(journey: object)
            }
        }
        .padding()
        .padding(.top)
    }
    
    func InactiveJourneyView() -> some View {
        LazyVStack(spacing: 10) {
            ServeJourneyData(activePredicate: false) { (object: Journey) in
                JourneyCard(journey: object)
            }
        }
        .padding()
        .padding(.top)
    }
    
    func JourneyCard(journey: Journey) -> some View {
        HStack(alignment: .top, spacing: 20) {
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(journey.journeyName ?? "No Value")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                        Text("\(journey.journeyFinishedPath) of \(journey.journeyTotalPath) Path(s) completed")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                    }
                    .leadingHelper()
    
                    // MARK: Could add edit/delete button
                    
                    Button {
                        
                    } label: {
                        
                    }
                }
            }
            .foregroundColor(Color.Primary)
            .padding(15)
            .leadingHelper()
            .background(
                // Maybe add lineargradient?
                Color.Primary
                    .cornerRadius(10)
            )
        }
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
