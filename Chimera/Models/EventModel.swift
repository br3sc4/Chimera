//
//  EventModel.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import Foundation
import CloudKit

protocol CloudKitableProtocol {
    init?(record: CKRecord)
//    init(performer: String, place: String, date: Date, image: String?, isMemory: Bool, textMemos: [String]?, vocalMemos: [VocalMemo]?, mediaMemos: [MediaType]?)
    //var record: CKRecord { get set }
}

struct Event: Identifiable, Hashable, CloudKitableProtocol {
    let id = UUID()
    let performer: String
    var place: String
    var date: Date
    var image: String?
    var cover: URL?
    //var imageData: Data?
    var isMemory: Bool
    var textMemos: [String]?
    var vocalMemos: [VocalMemo]?
    var mediaMemos: [MediaMemo]?
    var recordID: CKRecord.ID?
    
    init(performer: String, place: String, date: Date, image: String? = nil, cover: URL? = nil, isMemory: Bool, textMemos: [String]? = nil, vocalMemos: [VocalMemo]? = nil, mediaMemos: [MediaType]? = nil, recordID: CKRecord.ID? = nil) {
        self.performer = performer
        self.place = place
        self.date = date
        self.image = image
        self.cover = cover
        self.isMemory = isMemory
        self.textMemos = textMemos
        self.vocalMemos = vocalMemos
        self.mediaMemos = mediaMemos
        self.recordID = recordID
    }
}

struct VocalMemo: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var urlString: String
}

extension Event {
    init?(record: CKRecord) {
        guard let performer = record["performer"] as? String else { return nil }
        self.performer = performer
        guard let place = record["place"] as? String else { return nil }
        self.place = place
        guard let date = record["date"] as? Date else { return nil }
        self.date = date
        let imageAsset = record["image"] as? CKAsset
        if let url = imageAsset?.fileURL {
            self.cover = url //try? String(contentsOf: url)
        }
        guard let isMemory = record["isMemory"] as? Bool else { return nil }
        self.isMemory = isMemory
        self.recordID = record.recordID
        print("record \(record)")
    }
}

extension Event {
    var record: CKRecord {
        let record = CKRecord(recordType: "Event")
        record["performer"] = performer
        record["place"] = place
        record["date"] = date
//        if let urlString = image, let url = URL(string: urlString) {
//            let assets = CKAsset(fileURL: url)
//            record["image"] = assets
//        }
        
        if let url = cover {
            let assets = CKAsset(fileURL: url)
            record["image"] = assets
        }
        
        record["isMemory"] = isMemory
        return record
    }
}
