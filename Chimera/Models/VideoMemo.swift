//
//  VideoMemo.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 13/01/23.
//

import Foundation
import AVFoundation
import UIKit

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
    
    var thumbnail: UIImage? {
        let thumbnail = try? AVAssetImageGenerator(asset: videoAsset)
            .copyCGImage(at: .init(seconds: 0, preferredTimescale: 1), actualTime: nil)
        
        guard let thumbnail else { return nil }
        return UIImage(cgImage: thumbnail)
    }
    
    private var videoAsset: AVAsset {
        return AVAsset(url: url)
    }
}
