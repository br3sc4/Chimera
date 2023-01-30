//
//  MemoriesView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 16/01/23.
//

import SwiftUI

struct MemoriesView: View {
    @EnvironmentObject private var vm: EventVM
    @State var isShowingAddMemory = false
    var body: some View {
        NavigationStack
        {
            EventList(eventType: .memory)
                .navigationTitle("Memories")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            isShowingAddMemory.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $isShowingAddMemory) {
                    AddMemoryView()
                        .interactiveDismissDisabled()
                        .scrollDismissesKeyboard(.interactively)
                }
        }
    }
}

struct MemoriesView_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesView().environmentObject(EventVM())
    }
}
