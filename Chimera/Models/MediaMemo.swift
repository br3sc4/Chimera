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
import UIKit

struct MediaMemo: Identifiable, Hashable, CloudKitableProtocol {
    private(set) var url: URL
    var isVideo: Bool
    let id: UUID
    var record: CKRecord?
    private(set) var duration: Double? = nil
    private(set) var videoUrl: URL? = nil
    
    
    init(url: URL, isVideo: Bool, id: UUID = UUID(), record: CKRecord? = nil) {
//        print("media memo init standard")
        self.url = url
        self.isVideo = isVideo
        self.id = id
        self.record = record
    }
    
    init?(record: CKRecord) {
        print("media memo init da record")
        print("record \(record)")
        guard let isVideo = record["isVideo"] as? Bool else { return nil }
        self.isVideo = isVideo
        guard let mediaAssets = record["mediaURL"] as? CKAsset, let url = mediaAssets.fileURL else { return nil }
        self.url = url
        self.duration = record["duration"] as? Double
        self.id = UUID()
        self.record = record
    }
    
    init?<T: CloudKitableProtocol>(isVideo: Bool, url: URL, duration: Double? = nil, referenceItem: T) {
        print("media memo init da parameters")
        let record = CKRecord(recordType: "MediaMemo")
        record["isVideo"] = isVideo
        let mediaAsset = CKAsset(fileURL: url)
        record["mediaURL"] = mediaAsset
//        if let duration {
//            record["duration"] = duration
//        } else {
//            record["duration"] = 0.0
//        }
         record["duration"] = duration
        
//        if let videoUrl {
//            record["videoURL"] = CKAsset(fileURL: videoUrl)
//        }
        self.init(record: record)
        guard let referenceRecord = referenceItem.record else { return }
        record["owningEvent"] = CKRecord.Reference(record: referenceRecord, action: .deleteSelf)
    }
    
    mutating func createRecord<T: CloudKitableProtocol>(memo: MediaMemo, referenceItem: T) {
//        print("media memo createRecord")
        self.record = CKRecord(recordType: "MediaMemo")
        record?["isVideo"] = memo.isVideo
        let mediaAsset = CKAsset(fileURL: url)
        record?["mediaURL"] = mediaAsset
        record?["duration"] = duration
        if let videoUrl {
            record?["videoURL"] = CKAsset(fileURL: videoUrl)
        }
//        self.init(record: record)
        guard let referenceRecord = referenceItem.record else { return }
        record?["owningEvent"] = CKRecord.Reference(record: referenceRecord, action: .deleteSelf)
    }
   
}

extension MediaMemo {
    mutating func configureVideo() {
        videoUrl = url
        duration = videoAsset.duration.seconds
        
        guard let thumbnail = generateThumbnail() else { return }
        let image = UIImage(cgImage: thumbnail).pngData()
        let filePath = URL.cachesDirectory.appendingPathComponent("thumbanil_\(id)", conformingTo: .image)
        do {
            try image?.write(to: filePath)
            url = filePath
        } catch {
            debugPrint(error)
        }
        
    }
    
    enum FieldKeys {
        static let all: [String]? = nil
        static let exludeVideoAsset: [String] = ["mediaURL", "isVideo", "duration"]
    }
}

extension MediaMemo {
    func generateThumbnail() -> CGImage? {
        let generator = AVAssetImageGenerator(asset: videoAsset)
        debugPrint(generator)
        do {
            let image = try generator.copyCGImage(at: .init(seconds: 0,
                                                                preferredTimescale: 1),
                                                      actualTime: nil)
            debugPrint(image)
            return image
        } catch {
            debugPrint(error)
        }
        return nil
    }
    
    private var videoAsset: AVAsset {
        debugPrint(url, url.pathExtension)
        let asset = AVAsset(url: url)
        debugPrint(asset)
        return asset
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
