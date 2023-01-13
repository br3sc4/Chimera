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
        VideoMemo(name: "IMG_0684")
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            MediaCard(mediaName: "ConcertImageMemo")
            MediaCard(mediaName: "ConcertImageMemoVertical")
            MediaCard(mediaName: "ConcertImageMemo", mediaType: .video(duration: videos[0].mediaDuration))
            MediaCard(mediaName: "ConcertImageMemoVertical")
            MediaCard(mediaName: "ConcertImageMemo")
            MediaCard(mediaName: "ConcertImageMemoVertical", mediaType: .video(duration: videos[0].mediaDuration))
            MediaCard(mediaName: "ConcertImageMemo")
        }
    }
}

struct MediaGrid_Previews: PreviewProvider {
    static var previews: some View {
        MediaGrid()
    }
}
