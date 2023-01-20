//
//  MediaType.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 13/01/23.
//

import Foundation
import CoreGraphics

enum MediaType: Identifiable, Hashable {
    case image(name: String)
    case video(videoMemo: VideoMemo)
    
    var id: String {
        switch self {
        case .image(let name):
            return name
        case .video(let videoMemo):
            return videoMemo.url.description
        }
    }
}
