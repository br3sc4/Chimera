//
//  MediaCard.swift
//  Chimera
//
//  Created by Antonella Giugliano on 25/01/23.
//

import SwiftUI

struct MediaCard<ContentType>: View {
    private let memo: MediaMemo<ContentType>
    
    init(memo: MediaMemo<ContentType>) {
        self.memo = memo
    }
    
    var body: some View {
        if memo.isVideo {
            EmptyView()
//            if let content = memo.content as? URL,
//                let thumbnail = memo.thumbnail,
//                let uiImage = UIImage(cgImage: thumbnail) {
//                Image(uiImage: uiImage)
//                    .squared()
//                    .overlay(alignment: .bottomTrailing) {
//                        let convertedDuration = secondsToMinutesSeconds(ceil(memo.mediaDuration))
//
//                        Text("\(convertedDuration.minutes):\(convertedDuration.seconds.formatted(.number.precision(.integerLength(2))))")
//                            .font(.footnote)
//                            .foregroundColor(.white)
//                            .padding(.trailing, 8)
//                            .padding(.bottom, 4)
//                    }
//            }
        } else {
            if let data = memo.content as? Data {
                if let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .squared()
                }
            } else if let url = memo.content as? URL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case let .success(image):
                        image.squared()
                    case .empty:
                        EmptyView()
                    case let .failure(error):
                        EmptyView()
                    }
                }
            }
        }
    }
    
    private func secondsToMinutesSeconds(_ seconds: Double) -> (minutes: Int, seconds: Int) {
        return ((Int(seconds) % 3600) / 60, (Int(seconds) % 3600) % 60)
    }
}

struct MediaCard_Previews: PreviewProvider {
    static var previews: some View {
        MediaCard1(type: .image(name: "ConcertImageMemo"))
        MediaCard1(type: .video(videoMemo: VideoMemo(name: "IMG_0684")))
    }
}

