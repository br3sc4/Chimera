//
//  ContentView.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 11/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
    let saveAction: ()->Void
    
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
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(saveAction: {})
    }
}
    
