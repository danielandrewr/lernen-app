//
//  ContentView.swift
//  Lernen
//
//  Created by Daniel Roong on 21/07/22.
//

import SwiftUI

struct JourneyView: View {
    
    // MARK: Defines the viewModels
    @StateObject var timeModel = TimeViewModel()
    @StateObject var pathModel = PathViewModel()
    
    // MARK: Core Data MOC
    @Environment(\.managedObjectContext) var persistentContainer
    
    // MARK: Namespaces
    @Namespace var focus
    
    var body: some View {
        JourneyView()
    }
    
    // MARK: Home View
    func HomeView() -> some View {
        VStack(alignment: .center, spacing: 25) {
            Text("Home View")
                .padding()
            
            Image(systemName: "house")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
        }
    }
    
    // MARK: Profile View
    func ProfileView() -> some View {
        VStack(alignment: .center, spacing: 25) {
            Text("Profile View")
                .padding()
            
            Image(systemName: "person")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
        }
    }
    
    // MARK: Journey View
    func JourneyView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 5, pinnedViews: [.sectionHeaders]) {
                Section {
                    ScrollView(.horizontal ,showsIndicators: false) {
                        HStack(spacing: 10) {
                            
                            // MARK: Displays every days data from time viewModel and embed it in a VStack
                            ForEach(timeModel.currentWeek, id: \.self) { days in
                                
                                VStack(spacing: 10) {
                                    // MARK: Transform data from date to readable format
                                    Text(timeModel.extractDate(from: days, format: "dd"))
                                        .font(.system(size: 14))
                                        .fontWeight(timeModel.isDateToday(date: days) ? .bold : .regular)
                                        .foregroundColor(timeModel.isDateToday(date: days) ? Color.white : Color.Primary)
                                    
                                    Text(timeModel.extractDate(from: days, format: "EEE"))
                                        .font(.system(size: 12))
                                        .fontWeight(timeModel.isDateToday(date: days) ? .bold : .regular)
                                        .foregroundColor(timeModel.isDateToday(date: days) ? Color.white : Color.Primary)
                                }
                                
                                // MARK: Applies styling for capsule according to today's date
                                .foregroundStyle(timeModel.isDateToday(date: days) ? .primary : .secondary)
                                .foregroundColor(timeModel.isDateToday(date: days) ? .white : Color.Primary)
                                .frame(width: 45, height: 80)
                                    .background(
                                        ZStack {
                                            if timeModel.isDateToday(date: days) {
                                                Capsule()
                                                    .fill(Color.Primary)
                                                    .matchedGeometryEffect(id: "todaysdate", in: focus)
                                            }
                                        
                                        })
                                .contentShape(Capsule())
                                
                                // MARK: Dissapearing animation on capsule clicked
                                .onTapGesture {
                                    withAnimation {
                                        timeModel.today = days
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .centerHelper()
                    }
                    
                    PathView()
                } header: {
                    HeaderView()
                }
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    // MARK: Paths View
    func PathView() -> some View {
        LazyVStack(spacing: 25) {
            ServePathData(datePredicate: timeModel.today) { (object: Path) in
                PathCardComponent(path: object)
            }
        }
        .padding()
        .padding(.top)
    }
    
    // MARK: HeaderView for Journey's View
    func HeaderView() -> some View {
        
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Journey")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color.Primary)
            }
            .leadingHelper()
            
            Button {
                pathModel.addNewPath.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.Primary)
                    
                    .trailingHelper()
            }
            // MARK: Present AddNewPath View on Click using sheet to prevent layout errors
            .sheet(isPresented: $pathModel.addNewPath) {
                AddNewPath()
            }
        }
        .padding()
        .padding(.top, safeAreaBounds().top)
        .background(Color.white)
    }
    
    func PathCardComponent(path: Path) -> some View {
        HStack(alignment: .top, spacing: 30) {
            VStack() {
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(path.pathName ?? "No Value")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(pathModel.isPathInCurrentHour(date: path.pathDate ?? Date()) ? Color.white : Color.Primary)
                        
                        Text(path.pathDescription ?? "No Description")
                            .font(.subheadline.weight(.regular))
                            .foregroundColor(pathModel.isPathInCurrentHour(date: path.pathDate ?? Date()) ? Color.white : Color.Primary)
                        
                    }
                    .leadingHelper()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                    
                        Text("\(path.pathDate?.formatted(date: .omitted, time: .shortened) ?? Date().formatted(date: .omitted, time: .shortened))")
                            .font(.headline)
                            .foregroundColor(pathModel.isPathInCurrentHour(date: path.pathDate ?? Date()) ? Color.white : Color.Primary)
                            .padding(.top, 2.75)
                            .padding(.trailing, 0)
                        
                        if (!path.isFinished) {
                            if pathModel.isPathInCurrentHour(date: path.pathDate ?? Date()) {
                                Button {
                                    path.isFinished = true
                                    do {
                                        try persistentContainer.save()
                                    } catch let error as NSError {
                                        print(error.localizedDescription)
                                        print("Lernen: Failed to save to context")
                                    }
                                } label: {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .foregroundColor(Color.white)
                                        .padding(15)
                                        .frame(width: 50, height: 50, alignment: .center)
                                }
                            }
                        } else {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color.green)
                                .padding(10)
                                .frame(width: 50, height: 50, alignment: .center)
                            
                        }
                    }
                    .trailingHelper()
                }
            }
            .foregroundColor(pathModel.isPathInCurrentHour(date: path.pathDate ?? Date()) ? Color.white : Color.Secondary)
            .padding(pathModel.isPathInCurrentHour(date: path.pathDate ?? Date()) ? 15 : 0)
            .padding(.bottom, pathModel.isPathInCurrentHour(date: path.pathDate ?? Date()) ? 0 : 10)
            .trailingHelper()
            .background(
                Color.Tertiary
                    .cornerRadius(25)
                    .opacity(pathModel.isPathInCurrentHour(date: path.pathDate ?? Date()) ? 1 : 0)
            )
            
            VStack (spacing: 10) {
                Circle()
                    .fill(pathModel.isPathInCurrentHour(date: path.pathDate ?? Date()) ? Color.Primary : Color.clear)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(Color.Primary, lineWidth: 1)
                            .padding(-3)
                    )
                    .scaleEffect(pathModel.isPathInCurrentHour(date: path.pathDate ?? Date()) ? 0.7 : 1)
            
                Rectangle()
                    .fill(Color.Primary)
                    .frame(width: 5)
            }
            
        }
        .trailingHelper()
    }
}

struct Journey_Previews: PreviewProvider {
    static var previews: some View {
        JourneyView()
    }
}
