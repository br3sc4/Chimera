//
//  ImageMemo.swift
//  Chimera
//
//  Created by Antonella Giugliano on 25/01/23.
//

import Foundation


struct MediaMemo<Content>: Identifiable, Codable where Content: Codable {
    let content: Content
    let isVideo: Bool
    let id: UUID //= UUID()
    
    init(content: Content, isVideo: Bool = false) {
        self.content = content
        self.isVideo = isVideo
        self.id = UUID()
    }
    
    
    func encode(to encoder: Encoder) throws {
        <#code#>
    }
    
    
}
//
//extension MediaMemo: Codable where Content: StringProtocol {
//
//    private enum CodingKey: CodingKeys {
//
//        case content = "content"
//        case isVideo = "isVideo"
//    }
//
//}
