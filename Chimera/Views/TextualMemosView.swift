//
//  TextualMemosView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 24/01/23.
//

import SwiftUI

struct TextualMemosView: View {
    @EnvironmentObject var vm: AddMemoryVM
    @State var isShowingAddTextMemo = false
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            ForEach(vm.textMemos, id:\.self){ memo in
                TextMemoRow(textMemo: memo)
            }
            Spacer()
            .navigationTitle("Textual Memos")
            
        }.toolbar{
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isShowingAddTextMemo.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
    }.sheet(isPresented: $isShowingAddTextMemo, content: {AddTextMemoView()})
    }
}

struct TextualMemosView_Previews: PreviewProvider {
    static var previews: some View {
        TextualMemosView().environmentObject(AddMemoryVM())
    }
}
