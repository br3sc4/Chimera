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
    
    
    var currentDate: Date {
        let calendar = Calendar.current
        let startTime = calendar.startOfDay(for: Date())
        return startTime
    }
    
    
    private let service: CloudKitService
    
    init(service: CloudKitService) {
        self.service = service
        fetch()
        
    }
    
    func fetch() {
        
        Task {
//            let predicate = NSPredicate(value: true)
            let predicate =  NSPredicate(format: "date <= %@", currentDate as NSDate)
            
            self.events = try await service.fetch(predicate: predicate, recordType: "Event")
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
