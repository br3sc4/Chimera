//
//  ChimeraApp.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 11/01/23.
//

import SwiftUI

@main
struct ChimeraApp: App {
    
    @StateObject private var store = EventStore()
    
    @StateObject var vm = EventVM()
    @StateObject var addVM = AddEventVM()
    var body: some Scene {
        WindowGroup {
            ContentView(saveAction: {
                EventStore.save(events: store.eventStore) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
                    }).environmentObject(vm).environmentObject(addVM)
                .onAppear{
                    EventStore.loadAllEvents { result in
                        switch result {
                        case .failure(let error):
                            fatalError(error.localizedDescription)
                        case .success(let events):
                            store.eventStore = events
                        }
                    }
                }
        }
    }
}
