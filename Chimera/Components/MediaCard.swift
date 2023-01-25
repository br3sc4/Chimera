//
//  MediaCard.swift
//  Chimera
//
//  Created by Antonella Giugliano on 25/01/23.
//

import SwiftUI

struct MediaCard: View {
    private let memo: MediaMemo<Data>
    
    init(memo: MediaMemo<Data>) {
        self.memo = memo
    }
    
    var body: some View {
        if memo.isVideo {
            EmptyView()
//            Image(uiImage: thumbnail)
//                .squared()
//                .overlay(alignment: .bottomTrailing) {
//                    let convertedDuration = secondsToMinutesSeconds(ceil(video.mediaDuration))
//
//                    Text("\(convertedDuration.minutes):\(convertedDuration.seconds.formatted(.number.precision(.integerLength(2))))")
//                        .font(.footnote)
//                        .foregroundColor(.white)
//                        .padding(.trailing, 8)
//                        .padding(.bottom, 4)
//                }
        } else {
            if let uiImage = UIImage(data: memo.content) {
                Image(uiImage: uiImage)
                    .squared()
            }
        }
//        switch type {
//        case .image(let name):
//            Image(name)
//                .squared()
//        case .video(let video):
//            if let thumbnail = video.thumbnail {
//                Image(uiImage: thumbnail)
//                    .squared()
//                    .overlay(alignment: .bottomTrailing) {
//                        let convertedDuration = secondsToMinutesSeconds(ceil(video.mediaDuration))
//
//                        Text("\(convertedDuration.minutes):\(convertedDuration.seconds.formatted(.number.precision(.integerLength(2))))")
//                            .font(.footnote)
//                            .foregroundColor(.white)
//                            .padding(.trailing, 8)
//                            .padding(.bottom, 4)
//                    }
//            }
//        case let .data(_, data):
//            if let uiImage = UIImage(data: data) {
//                Image(uiImage: uiImage)
//                    .squared()
//            }
//        }
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

