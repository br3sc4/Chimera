//
//  UpcomingEventVM.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 01/02/23.
//

import Foundation

class UpcomingEventVM: ObservableObject {
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
    
    func addUpcomingEvent(_ event: Event) {
        events.append(event)
    }
}
