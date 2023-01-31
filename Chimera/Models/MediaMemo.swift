//
//  ImageMemo.swift
//  Chimera
//
//  Created by Antonella Giugliano on 25/01/23.
//

import Foundation
import AVFoundation
import CoreTransferable

struct MediaMemo: Identifiable, Hashable {
    let url: URL
    var isVideo: Bool
    let id: UUID
    
    init(url: URL, isVideo: Bool = false, id: UUID = UUID()) {
        self.url = url
        self.isVideo = isVideo
        self.id = id
    }
}

extension MediaMemo: Codable {
    private enum CodingKeys: String, CodingKey {
        case url
        case isVideo
        case id
    }
}

extension MediaMemo {
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
        return AVAsset(url: url)
    }
}

extension MediaMemo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(importedContentType: .data) { received in
            let id = UUID()
            let ext = received.file.absoluteString.split(separator: "/").last?.split(separator: ".").last
            let fileName = "\(id.uuidString).\(ext ?? "png")"
            let filePath = URL.cachesDirectory.appendingPathComponent(fileName)
            do {
                try FileManager.default.copyItem(at: received.file, to: filePath)
            } catch {
                debugPrint(error)
                throw error
            }
            return Self.init(url: filePath, isVideo: false, id: id)
        }
    }
}
