//
//  UpcomingEventVM.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 01/02/23.
//

import Foundation

@MainActor
class UpcomingEventVM: ObservableObject {
    
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
            //let predicate = NSPredicate(value: true)
            
            let predicate =  NSPredicate(format: "date > %@", currentDate as NSDate)
            
            self.events = try await service.fetch(predicate: predicate, recordType: "Event")
        }
    }
    
    func addEvent(_ event: Event) async {
        guard let event = Event(performer: event.performer, place: event.place, date: event.date, cover: event.cover, isMemory: event.isMemory) else { return }
        do {
            try await service.add(item: event)
            appendEvent(event)
        } catch {
            debugPrint(error)
        }
    }
    
    func appendEvent(_ event: Event) {
        events.append(event)
    }
}


/*
 @Published var events: [Event] = [
 Event(
 performer: "Imagine Dragons",
 place: "Munich",
 date: {
 var components = DateComponents()
 components.year = 2022
 components.month = 11
 components.day = 25
 return components.date ?? Date.now
 }(),
 image: "event1",
 isMemory: false
 ),
 Event(
 performer: "Foo Fighters",
 place: "London",
 date: {
 var components = DateComponents()
 components.year = 2019
 components.month = 7
 components.day = 30
 return components.date ?? Date.now
 }(),
 image: "event2",
 isMemory: false
 ),
 Event(
 performer: "Bon Iver",
 place: "Milan",
 date: {
 var components = DateComponents()
 components.year = 2022
 components.month = 11
 components.day = 8
 return components.date ?? Date.now
 }(),
 image: "event3", isMemory: false
 ),
 Event(
 performer: "Imagine Dragons",
 place: "Munich",
 date: {
 var components = DateComponents()
 components.year = 2022
 components.month = 11
 components.day = 25
 return components.date ?? Date.now
 }(),
 image: "event1",
 isMemory: false
 )
 ]
 */
