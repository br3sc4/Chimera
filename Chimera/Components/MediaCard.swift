//
//  MediaCard.swift
//  Chimera
//
//  Created by Antonella Giugliano on 25/01/23.
//

import SwiftUI

struct MediaCard: View {
    private let memo: MediaMemo
    
    init(memo: MediaMemo) {
        self.memo = memo
    }
    
    var body: some View {
        if memo.isVideo {
            if let thumbnail = memo.thumbnail {
                Image(uiImage: UIImage(cgImage: thumbnail))
                    .squared()
                    .overlay(alignment: .bottomTrailing) {
                        let convertedDuration = secondsToMinutesSeconds(ceil(memo.mediaDuration))

                        Text("\(convertedDuration.minutes):\(convertedDuration.seconds.formatted(.number.precision(.integerLength(2))))")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .padding(.trailing, 8)
                            .padding(.bottom, 4)
                    }
            }
        } else {
            AsyncImage(url: memo.url) { phase in
                switch phase {
                case let .success(image):
                    image.squared()
                case .empty:
                    ProgressView()
                case let .failure(error):
                    Text(error.localizedDescription)
                @unknown default:
                    fatalError()
                }
            }
        }
    }
    
    private func secondsToMinutesSeconds(_ seconds: Double) -> (minutes: Int, seconds: Int) {
        return ((Int(seconds) % 3600) / 60, (Int(seconds) % 3600) % 60)
    }
}

//struct MediaCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MediaCard(type: .image(name: "ConcertImageMemo"))
//        MediaCard(type: .video(videoMemo: VideoMemo(name: "IMG_0684")))
//    }
//}

