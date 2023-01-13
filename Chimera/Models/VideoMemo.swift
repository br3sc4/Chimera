//
//  VideoMemo.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 13/01/23.
//

import Foundation
import AVFoundation

struct VideoMemo {
    let name: String
    
    var mediaDuration: Double {
        let time = videoAsset.duration
        return time.seconds
    }
    
    var thumbnail: CGImage? {
        try? AVAssetImageGenerator(asset: videoAsset)
            .copyCGImage(at: .init(seconds: 0, preferredTimescale: 1), actualTime: nil)
    }
    
    private var videoAsset: AVAsset {
        let videoURL = Bundle.main.url(forResource: name, withExtension: "mov")!
        return AVAsset(url: videoURL)
    }
}
