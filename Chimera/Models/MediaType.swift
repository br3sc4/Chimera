//
//  MediaType.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 13/01/23.
//

import Foundation

enum MediaType: Identifiable, Hashable {
    case image(name: String)
    case video(videoMemo: VideoMemo)
    case data(id: UUID, data: Data)
    
    var id: String {
        switch self {
        case let .image(name):
            return name
        case let .video(videoMemo):
            return videoMemo.url.description
        case let .data(id, _):
            return id.uuidString
        }
    }
}
