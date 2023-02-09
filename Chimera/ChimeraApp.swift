//
//  ChimeraApp.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 11/01/23.
//

import SwiftUI

@main
struct ChimeraApp: App {
    @StateObject private var eventVM: EventVM
    @StateObject private var addEventVM: AddEventVM
    @StateObject private var addMemoryVM: AddMemoryVM
    @StateObject private var upcomingVM: UpcomingEventVM
    
    init() {
        _eventVM = StateObject(wrappedValue: EventVM(service: CloudKitService()))
        _addEventVM = StateObject(wrappedValue: AddEventVM(service: CloudKitService()))
        _addMemoryVM = StateObject(wrappedValue: AddMemoryVM(service: CloudKitService()))
        _upcomingVM = StateObject(wrappedValue: UpcomingEventVM(service: CloudKitService()))
        
        NotificationCenter.default.addObserver(forName: .CKAccountChanged, object: self, queue: nil) { notification in
             //
            print("notification \(notification)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(eventVM)
                .environmentObject(addEventVM)
                .environmentObject(addMemoryVM)
                .environmentObject(upcomingVM)
        }
    }
}
