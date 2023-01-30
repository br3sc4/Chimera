//
//  AddMemorySectionRow.swift
//  Chimera
//
//  Created by Antonella Giugliano on 24/01/23.
//

import SwiftUI

struct AddMemorySectionRow: View {
    var imageIcon: String
    var memoName: String
    var body: some View {
        HStack{
            ZStack{
                Image(systemName: "square.fill")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 28))
                Image(systemName: imageIcon)
                    .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
            }
            Text(memoName)
        }
    }
}

struct AddMemorySectionRow_Previews: PreviewProvider {
    static var previews: some View {
        AddMemorySectionRow(imageIcon: "mic.fill", memoName: "Vocal Memo")
    }
}
