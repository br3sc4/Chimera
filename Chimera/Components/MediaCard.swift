//
//  MediaCard.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 12/01/23.
//

import SwiftUI

struct MediaCard: View {
    private let type: MediaType
    
    init(type: MediaType) {
        self.type = type
    }
    
    var body: some View {
        switch type {
        case .image(let name):
            Image(name)
                .squared()
        case .video(let duration, let thumbnail):
            if let thumbnail {
                Image(thumbnail, scale: 1, label: Text(""))
                    .squared()
                    .overlay(alignment: .bottomTrailing) {
                        let convertedDuration = secondsToMinutesSeconds(ceil(duration))
                        
                        Text("\(convertedDuration.minutes):\(convertedDuration.seconds.formatted(.number.precision(.integerLength(2))))")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .padding(.trailing, 8)
                            .padding(.bottom, 4)
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
        MediaCard(type: .image(name: "ConcertImageMemo"))
        MediaCard(type: .video(duration: 5))
    }
}
