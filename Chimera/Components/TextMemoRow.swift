//
//  TextMemoRow.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct TextMemoRow: View {
    
    let textMemo: TextMemoModel
    @State var showTextMemo = false
    var body: some View {
        Button(action: {showTextMemo.toggle()}, label: {
            HStack{
                Image(systemName: "note.text")
                    .foregroundColor(.accentColor)
                Text(textMemo.text)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
        }).sheet(isPresented: $showTextMemo) {
            TextMemo(textMemo: textMemo.text)
                .presentationDetents([.medium])
        }
    }
}


struct TextMemoRow_Previews: PreviewProvider {
    static var previews: some View {
        TextMemoRow(textMemo: TextMemoModel(text: "events[0].textMemos![0]"))
    }
}
