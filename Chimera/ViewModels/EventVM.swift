//
//  EventVM.swift
//  Chimera
//
//  Created by Antonella Giugliano on 18/01/23.
//

import Foundation
import SwiftUI
import PhotosUI
import CloudKit

@MainActor
class EventVM: ObservableObject {
    @Published var events: [Event] = []
    @Published var vocalMemos: [VocalMemo] = []
    
    private let service: CloudKitService
    
    init(service: CloudKitService) {
        self.service = service
        fetch()
        
    }
    
    func fetch() {
        
        Task {
            let predicate = NSPredicate(value: true)
            
            self.events = try await service.fetch(predicate: predicate, recordType: "Event")
            print("events \(events)")
//            fetchVocalMemo()
        }
    }
    
//    func fetchVocalMemo() {
//        guard let event = events[0].record else { return }
//        Task {
//            let eventID = event.recordID
//            let recordToMatch = CKRecord.Reference(recordID: eventID, action: .deleteSelf)
//            let predicate = NSPredicate(format: "owningEvent == %@", recordToMatch)
//
//            self.vocalMemos = try await service.fetch(predicate: predicate, recordType: "VocalMemo")
//            print("vocalmemo \(vocalMemos) count: \(vocalMemos.count)")
//        }
//    }
    
    func fetchMemo(event: inout Event) async { //Binding<Event>
        guard let record = event.record else { return } //wrappedValue
        let eventID = record.recordID
        let recordToMatch = CKRecord.Reference(recordID: eventID, action: .deleteSelf)
        let predicate = NSPredicate(format: "owningEvent == %@", recordToMatch)
        do {
            async let vocalMemo: [VocalMemo] = try service.fetch(predicate: predicate, recordType: "VocalMemo")
            async let textMemo: [TextMemoModel] = try service.fetch(predicate: predicate, recordType: "TextMemo")
            async let mediaMemo: [MediaMemo] = try service.fetch(predicate: predicate, recordType: "MediaMemo")
//            event.wrappedValue.vocalMemos = try await vocalMemo
            event.textMemos = try await textMemo
//            event.wrappedValue.mediaMemos = try await mediaMemo
//            let textMemo: [TextMemoModel] = try await service.fetch(predicate: predicate, recordType: "TextMemo")
            print("textmemo \(try await textMemo) count: \(try await textMemo.count)")
        } catch {
            print(error)
        }
        

    }
    
    func deleteItem(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let event = events[index]
        guard let record = event.record else { return }
        
        Task {
            try await service.delete(recordID: record.recordID)
            events.remove(at: index)
        }
    }
    
   
}
