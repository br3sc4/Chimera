//
//  TextMemoModel.swift
//  Chimera
//
//  Created by Nicola Rigoni on 03/02/23.
//

import Foundation
import CloudKit

struct TextMemoModel: Identifiable, Hashable, CloudKitableProtocol {
    var text: String
    let id: UUID
    var record: CKRecord?
    
    init(text: String, id: UUID = UUID(), record: CKRecord? = nil) {
        self.text = text
        self.id = id
        self.record = record
    }
    
    init?(record: CKRecord) {
//        print("text memo init da record")
        guard let text = record["text"] as? String else { return nil }
        self.text = text
        self.id = UUID()
        self.record = record
//        print("record \(record)")
    }
    
    init?<T: CloudKitableProtocol>(text: String, referenceItem: T) {
//        print("text memo init da parameters")
        let record = CKRecord(recordType: "TextMemo")
        record["text"] = text
        self.init(record: record)
        guard let referenceRecord = referenceItem.record else { return }
        record["owningEvent"] = CKRecord.Reference(record: referenceRecord, action: .deleteSelf)
    }
    
}
