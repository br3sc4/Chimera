//
//  EventView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject private var eventVM: EventVM
    var event: Event
    var body: some View {
        List {
            if let textMemos = event.textMemos,
                !textMemos.isEmpty {
                Section("Textual Memos") {
                    ForEach(textMemos, id: \.self){ textMemo in
                        TextMemoRow(textMemo: textMemo)
                    }
                }
            }
            
            if let vocalMemos = event.vocalMemos,
                !vocalMemos.isEmpty {
                Section("Vocal Memos") {
                    ForEach(vocalMemos){ vocalMemo in
                        VocalMemoRow(vocalMemo: vocalMemo)
                    }
                }
            }
            
            if let mediaMemos = event.mediaMemos,
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
        .navigationTitle(event.performer)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event(performer: "event1", place: "Name of Performer", date: Date.now, image: "Place", isMemory: true))
            .environmentObject(AddMemoryVM(service: CloudKitService()))
    }
}
