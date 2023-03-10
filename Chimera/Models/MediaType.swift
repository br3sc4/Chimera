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
        case let .image(name):
            return name
        case let .video(videoMemo):
            return videoMemo.url.description
        }
    }
}
