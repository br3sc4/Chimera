//
//  AddTextMemoView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 24/01/23.
//

import SwiftUI

struct AddTextMemoView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: AddMemoryVM
    @State var text = ""
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    ZStack{
                        Image(systemName: "square.fill")
                            .foregroundColor(.accentColor)
                            .font(.system(size: 34))
                        Image(systemName: "pencil.line")
                            .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                    }
                    TextField("Write your memory here", text: $text, axis: .vertical)
                }
                .toolbar{
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            vm.textMemos.append(text)
                            dismiss()
                        }, label: {
                            Text("Done")
                        })
                    }
            }
                Spacer()
            }
        }
    }
}

struct AddTextMemoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTextMemoView().environmentObject(AddMemoryVM())
    }
}
