//
//  ContentView.swift
//  Lernen-App
//
//  Created by Daniel Roong on 26/07/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Overview()
                .tabItem {
                    Image(systemName: "house")
                    Text("Overview")
                        .font(.system(size: 16))
                }
            JourneyView()
                .tabItem {
                    Image(systemName: "chart.bar.doc.horizontal")
                    Text("Journey")
                        .font(.system(size: 16))
                }
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
