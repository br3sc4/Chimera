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
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(vm)
        }
    }
}
