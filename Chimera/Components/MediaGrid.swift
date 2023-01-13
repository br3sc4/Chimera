//
//  MediaGrid.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 12/01/23.
//

import SwiftUI

struct MediaGrid: View {
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 2)
    ]
    
    private let videos: [VideoMemo] = [
        VideoMemo(name: "IMG_0684"),
        VideoMemo(name: "Video")
    ]
    
    var body: some View {
        List {
            LazyVGrid(columns: columns, spacing: 2) {
                MediaCard(mediaName: "ConcertImageMemo")
                MediaCard(mediaName: "ConcertImageMemoVertical")
                MediaCard(mediaName: "ConcertImageMemo", mediaType: .video(duration: videos[0].mediaDuration))
                MediaCard(mediaName: "ConcertImageMemoVertical")
                MediaCard(mediaName: "ConcertImageMemo")
                MediaCard(mediaName: "ConcertImageMemoVertical", mediaType: .video(duration: videos[1].mediaDuration))
                MediaCard(mediaName: "ConcertImageMemo")
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
    }
}

struct MediaGrid_Previews: PreviewProvider {
    static var previews: some View {
        MediaGrid()
    }
}
