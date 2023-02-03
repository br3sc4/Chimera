//
//  SingleEventVM.swift
//  Chimera
//
//  Created by Nicola Rigoni on 03/02/23.
//

import Foundation
import CloudKit

@MainActor
class SingleEventVM: ObservableObject {
    @Published var event: Event
    
    private let service: CloudKitService
    
    init(event: Event, service: CloudKitService) {
        self.event = event
        self.service = service
        Task {
            await fetchMemo()
        }
//        fetch()
    }
    
    func fetchMemo() async { //Binding<Event>
        guard let record = event.record else { return } //wrappedValue
        let eventID = record.recordID
        let recordToMatch = CKRecord.Reference(recordID: eventID, action: .deleteSelf)
        let predicate = NSPredicate(format: "owningEvent == %@", recordToMatch)
        do {
            async let vocalMemo: [VocalMemo] = try service.fetch(predicate: predicate, recordType: "VocalMemo")
            async let textMemo: [TextMemoModel] = try service.fetch(predicate: predicate, recordType: "TextMemo")
            async let mediaMemo: [MediaMemo] = try service.fetch(predicate: predicate, recordType: "MediaMemo")
            event.vocalMemos = try await vocalMemo
            event.textMemos = try await textMemo
            event.mediaMemos = try await mediaMemo
//            let textMemo: [TextMemoModel] = try await service.fetch(predicate: predicate, recordType: "TextMemo")
        } catch {
            print(error)
        }
        

    }
    
}
