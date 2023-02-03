//
//  EventView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject private var eventVM: EventVM
    //var event: Event
    @StateObject private var vm: SingleEventVM
    
    init(event: Event) {
        self._vm = StateObject(wrappedValue: SingleEventVM(event: event, service: CloudKitService()))
    }
    
    var body: some View {
        List {
            if let textMemos = vm.event.textMemos,
                !textMemos.isEmpty {
                Section("Textual Memos") {
                    ForEach(textMemos, id: \.self){ textMemo in
                        TextMemoRow(textMemo: textMemo)
                    }
                }
            }
            
            if let vocalMemos = vm.event.vocalMemos,
                !vocalMemos.isEmpty {
                Section("Vocal Memos") {
                    ForEach(vocalMemos){ vocalMemo in
                        VocalMemoRow(vocalMemo: vocalMemo)
                    }
                }
            }
            
            if let mediaMemos = vm.event.mediaMemos,
                !mediaMemos.isEmpty {
                Section("Media Memos") {
                    MediaGrid(media: mediaMemos)
                        .listRowInsets(EdgeInsets())
                }
            }
        }
//        .task {
//            await eventVM.fetchMemo(event: event)
//        }
        .navigationTitle(vm.event.performer)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event(performer: "event1", place: "Name of Performer", date: Date.now, image: "Place", isMemory: true))
            .environmentObject(AddMemoryVM(service: CloudKitService()))
    }
}
