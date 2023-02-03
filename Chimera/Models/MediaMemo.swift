//
//  ImageMemo.swift
//  Chimera
//
//  Created by Antonella Giugliano on 25/01/23.
//

import Foundation
import AVFoundation
import CoreTransferable
import CloudKit

struct MediaMemo: Identifiable, Hashable, CloudKitableProtocol {
    let url: URL
    var isVideo: Bool
    let id: UUID
    var record: CKRecord?
    
    
    init(url: URL, isVideo: Bool, id: UUID = UUID(), record: CKRecord? = nil) {
//        print("media memo init standard")
        self.url = url
        self.isVideo = isVideo
        self.id = id
        self.record = record
    }
    
    init?(record: CKRecord) {
//        print("media memo init da record")
        guard let isVideo = record["isVideo"] as? Bool else { return nil }
        self.isVideo = isVideo
        guard let mediaAssets = record["mediaURL"] as? CKAsset, let url = mediaAssets.fileURL else { return nil }
        self.url = url
        self.id = UUID()
        self.record = record
//        print("record \(record)")
    }
    
    init?<T: CloudKitableProtocol>(isVideo: Bool, url: URL, referenceItem: T) {
//        print("media memo init da parameters")
        let record = CKRecord(recordType: "MediaMemo")
        record["isVideo"] = isVideo
        let assets = CKAsset(fileURL: url)
        record["mediaURL"] = assets
        self.init(record: record)
        guard let referenceRecord = referenceItem.record else { return }
        record["owningEvent"] = CKRecord.Reference(record: referenceRecord, action: .deleteSelf)
    }
    
    mutating func createRecord<T: CloudKitableProtocol>(memo: MediaMemo, referenceItem: T) {
//        print("media memo createRecord")
        self.record = CKRecord(recordType: "MediaMemo")
        record?["isVideo"] = memo.isVideo
        let assets = CKAsset(fileURL: url)
        record?["mediaURL"] = assets
//        self.init(record: record)
        guard let referenceRecord = referenceItem.record else { return }
        record?["owningEvent"] = CKRecord.Reference(record: referenceRecord, action: .deleteSelf)
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
            let fileURL: URL = received.file
            let id = UUID()
            guard let ext = fileURL.absoluteString.split(separator: "/").last?.split(separator: ".").last else {
                throw FileError.extensionNotFound
            }
            let fileName = "\(id.uuidString).\(ext)"
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
    
    enum FileError: Error {
        case extensionNotFound
    }
}
