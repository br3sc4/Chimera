//
//  MediaMemosView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 25/01/23.
//

import SwiftUI
import PhotosUI

struct MediaMemosView: View {
    @EnvironmentObject var vm: AddMemoryVM
    
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 2)
    ]
    
    var body: some View {
        VStack{
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(vm.mediaMemo, id: \.id) { media in
                    MediaCard(memo: media)
                }
            }
            Spacer()
        }
        .toolbar{
            ToolbarItem(placement: .primaryAction) {
                PhotosPicker(selection: $vm.photoPickerItem, matching: .any(of: [.images, .videos])){
                    Image(systemName: "plus")
                    
                }
                .onChange(of: vm.photoPickerItem, perform: vm.loadImage)
                .foregroundColor(.accentColor)
            }
        }
    }
}


struct MediaMemosView_Previews: PreviewProvider {
    static var previews: some View {
        MediaMemosView().environmentObject(AddMemoryVM())
    }
}
