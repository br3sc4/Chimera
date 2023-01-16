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
        .onAppear {
            // correct the transparency bug for Tab bars
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            // correct the transparency bug for Navigation bars
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
