//
//  TextMemoRow.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct TextMemoRow: View {
    
    let textMemo: String
    @State var showTextMemo = false
    var body: some View {
        Button(action: {showTextMemo.toggle()}, label: {
            HStack{
                Image(systemName: "note.text")
                    .foregroundColor(.accentColor)
                Text(textMemo)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
        }).sheet(isPresented: $showTextMemo) {
            TextMemo(textMemo: textMemo)
                .presentationDetents([.medium])
        }
    }
}


struct TextMemoRow_Previews: PreviewProvider {
    static var previews: some View {
        TextMemoRow(textMemo: "events[0].textMemos![0]")
    }
}
