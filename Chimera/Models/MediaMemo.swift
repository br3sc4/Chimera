//
//  ImageMemo.swift
//  Chimera
//
//  Created by Antonella Giugliano on 25/01/23.
//

import Foundation

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
