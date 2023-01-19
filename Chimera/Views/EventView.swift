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
            if let textMemos = event.textMemos {
                Section("Textual Memos") {
                    ForEach(textMemos, id: \.self){ textMemo in
                        TextMemoRow(textMemo: textMemo)
                            .padding(.vertical)
                    }.listRowInsets(EdgeInsets())
                }
            }
            
            if let vocalMemos = event.vocalMemos {
                Section("Vocal Memos") {
                    ForEach(vocalMemos){ vocalMemo in
                        VocalMemoRow(vocalMemo: vocalMemo)
                            .padding(.vertical)
                    }.listRowInsets(EdgeInsets())
                }
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
