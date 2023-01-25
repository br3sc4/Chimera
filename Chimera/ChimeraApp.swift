//
//  ChimeraApp.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 11/01/23.
//

import SwiftUI

@main
struct ChimeraApp: App {
    @StateObject var vm = EventVM()
    @StateObject var addVM = AddEventVM()
    @StateObject var addMemoryVM = AddMemoryVM()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(vm).environmentObject(addVM).environmentObject(addMemoryVM)
        }
    }
}
