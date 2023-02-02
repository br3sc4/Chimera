//
//  ChimeraApp.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 11/01/23.
//

import SwiftUI

@main
struct ChimeraApp: App {
    @StateObject private var eventVM: EventVM = EventVM()
    @StateObject private var addEventVM: AddEventVM = AddEventVM()
    @StateObject private var upcomingVM: UpcomingEventVM = UpcomingEventVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(eventVM)
                .environmentObject(addEventVM)
                .environmentObject(upcomingVM)
        }
    }
}
