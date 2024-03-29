//
//  MediaGrid.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 12/01/23.
//

import SwiftUI

struct MediaGrid: View {
    @State private var selectedMedia: UUID = UUID()
    @State private var showPreview: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 2)
    ]
    
    private let media: [MediaMemo]
    
    init(media: [MediaMemo]) {
        self.media = media
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(media) { media in
                MediaCard(memo: media)
                    .onTapGesture {
                        selectedMedia = media.id
                        showPreview.toggle()
                        print("selectedMedia \(selectedMedia)")
                    }
            }
        }
        .navigationDestination(isPresented: $showPreview) {
            //MediaDetailView() //media: media, selectedItem: $selectedMedia
//            VStack {
//                Text("media detail")
//            }
            TestView(selectedItem: $selectedMedia, memo: media)
        }
    }
}

struct MediaGrid_Previews: PreviewProvider {
    static var previews: some View {
        MediaGrid(media: [
//            .image(name: "concert1"),
//            .image(name: "concert2"),
//            .video(videoMemo: VideoMemo(name: "Tamburellare - 5026", ext: "mp4")),
//            .image(name: "concert3"),
//            .video(videoMemo: VideoMemo(name: "Violoncello - 33565", ext: "mp4"))
        ])
    }
}
