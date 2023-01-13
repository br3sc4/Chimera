//
//  EventView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct EventView: View {
    let event: Event
    var body: some View {
        List {
            Section("Textual Memos") {
                ForEach(event.textMemos!, id: \.self){ textMemo in
                    TextMemoRow(textMemo: textMemo)
                        .padding(.vertical)
                }.listRowInsets(EdgeInsets())
            }
            Section("Vocal Memos") {
                ForEach(event.VocalMemos!){ vocalMemo in
                    VocalMemoRow(vocalMemo: vocalMemo)
                        .padding(.vertical)
                }.listRowInsets(EdgeInsets())
            }
        }
        .navigationTitle(event.performer)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: events[0])
    }
}