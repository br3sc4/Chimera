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
        let videoURL = Bundle.main.url(forResource: name, withExtension: "mov")!
        let videoAsset = AVAsset(url: videoURL)
        
        let time = videoAsset.duration
        return time.seconds
    }
}
