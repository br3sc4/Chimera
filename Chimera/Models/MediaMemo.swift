//
//  ImageMemo.swift
//  Chimera
//
//  Created by Antonella Giugliano on 25/01/23.
//

import Foundation
import AVFoundation

struct MediaMemo<Content>: Identifiable {
    let content: Content
    let isVideo: Bool
    let id: UUID
    
    init(content: Content, isVideo: Bool = false) {
        self.content = content
        self.isVideo = isVideo
        self.id = UUID()
    }
}

extension MediaMemo: Codable where Content: Codable {
    private enum CodingKeys: String, CodingKey {
        case content
        case isVideo
        case id
    }
}

extension MediaMemo where Content == URL {
    var mediaDuration: Double {
        let time = videoAsset.duration
        return time.seconds
    }
    
    var thumbnail: CGImage? {
        return try? AVAssetImageGenerator(asset: videoAsset)
            .copyCGImage(at: .init(seconds: 0,
                                   preferredTimescale: 1),
                         actualTime: nil)
    }
    
    private var videoAsset: AVAsset {
        return AVAsset(url: content)
    }
}
