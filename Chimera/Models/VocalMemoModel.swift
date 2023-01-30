//
//  VocalMemoModel.swift
//  Chimera
//
//  Created by Nicola Rigoni on 29/01/23.
//

import Foundation
import CloudKit

struct VocalMemo: Identifiable, Hashable, CloudKitableProtocol {
    
    let id = UUID()
    var title: String
    var urlString: String?
    var vocalURL: URL?
    var record: CKRecord?
    
    init(title: String, urlString: String? = nil, vocalURL: URL? = nil, record: CKRecord? = nil) {
        self.title = title
        self.urlString = urlString
        self.vocalURL = vocalURL
        self.record = record
    }
    
    init?(record: CKRecord) {
        print("Vocal memo init da record")
        guard let title = record["title"] as? String else { return nil }
        self.title = title
        let vocalAssets = record["vocal"] as? CKAsset
        if let url = vocalAssets?.fileURL {
            self.vocalURL = url
        }
        self.record = record
        print("record \(record)")
    }
    
    init?<T: CloudKitableProtocol>(title: String, vocalURL: URL?, referenceItem: T) {
        let record = CKRecord(recordType: "VocalMemo")
        record["title"] = title
        if let url = vocalURL {
            let assets = CKAsset(fileURL: url)
            record["vocal"] = assets
        }
        self.init(record: record)
        guard let referenceRecord = referenceItem.record else { return }
        record["owningEvent"] = CKRecord.Reference(record: referenceRecord, action: .deleteSelf)
    }
    
}
