//
//  TextualMemosView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 24/01/23.
//

import SwiftUI

struct TextualMemosView: View {
    @ObservedObject private var vm: AddMemoryVM
    @State var isShowingAddTextMemo = false
    
    init(addMemoryVM : AddMemoryVM) {
        self.vm = addMemoryVM
    }
    
    var body: some View {
        List {
            ForEach(vm.textMemos, id:\.self){ memo in
                TextMemoRow(textMemo: memo)
            }
        }
        .navigationTitle("Textual Memos")
        .toolbar{
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isShowingAddTextMemo.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isShowingAddTextMemo) {
            AddTextMemoView(addMemoryVM: vm)
        }
    }
}

struct TextualMemosView_Previews: PreviewProvider {
    static var previews: some View {
        TextualMemosView(addMemoryVM: AddMemoryVM(event: nil))
    }
}
