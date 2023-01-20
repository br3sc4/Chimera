//
//  VideoMemo.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 13/01/23.
//

import Foundation
import AVFoundation

struct VideoMemo: Hashable {
    private let name: String
    private let ext: String
    let url: URL
    
    init(name: String, ext: String = "mov") {
        self.name = name
        self.ext = ext
        self.url = Bundle.main.url(forResource: name, withExtension: ext)!
    }
    
    var mediaDuration: Double {
        let time = videoAsset.duration
        return time.seconds
    }
    
    var thumbnail: CGImage? {
        try? AVAssetImageGenerator(asset: videoAsset)
            .copyCGImage(at: .init(seconds: 0, preferredTimescale: 1), actualTime: nil)
    }
    
    private var videoAsset: AVAsset {
        return AVAsset(url: url)
    }
}
