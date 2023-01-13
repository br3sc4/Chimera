//
//  MediaCard.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 12/01/23.
//

import SwiftUI

struct MediaCard: View {
    private let mediaName: String
    private let mediaType: MediaType
    
    init(mediaName: String, mediaType: MediaType = .image) {
        self.mediaName = mediaName
        self.mediaType = mediaType
    }
    
    var body: some View {
        Image(mediaName)
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 0, maxHeight: .infinity)
            .clipped()
            .aspectRatio(1, contentMode: .fit)
            .overlay(alignment: .bottomTrailing) {
                if case let .video(duration) = mediaType {
                    let convertedDuration = secondsToMinutesSeconds(ceil(duration))
                    
                    Text("\(convertedDuration.minutes):\(convertedDuration.seconds.formatted(.number.precision(.integerLength(2))))")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.trailing, 8)
                        .padding(.bottom, 4)
                }
            }
    }
    
    func secondsToMinutesSeconds(_ seconds: Double) -> (minutes: Int, seconds: Int) {
        return ((Int(seconds) % 3600) / 60, (Int(seconds) % 3600) % 60)
    }
}

struct MediaCard_Previews: PreviewProvider {
    static var previews: some View {
        MediaCard(mediaName: "ConcertImageMemo")
        MediaCard(mediaName: "ConcertImageMemoVertical", mediaType: .video(duration: 5))
    }
}
