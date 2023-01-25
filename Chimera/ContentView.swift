//
//  ContentView.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 11/01/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            MemoriesView()
                .tabItem{
                    Label("Memories", systemImage: "memories")
                }
            UpcomingView()
                .tabItem{
                    Label("Upcoming", systemImage: "calendar.day.timeline.left")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
