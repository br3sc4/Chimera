//
//  TextMemo.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct TextMemo: View {
    let textMemo: String
    var body: some View {
                Text(textMemo)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
            }
}

struct TextMemo_Previews: PreviewProvider {
    static var previews: some View {
        TextMemo(textMemo: "events[0].textMemos![0]")
    }
}
