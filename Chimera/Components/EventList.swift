//
//  EventList.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct EventList: View {
    @State private var searchedEvent: String = ""
    @State private var tokens: [MemorySearchToken] = []
    private var events: [Event]
    private let eventType: EventTypes
    
    init(eventType: EventTypes, events: [Event]) {
        self.events = events
        self.eventType = eventType
    }
    
    var body: some View {
        List {
            if case .memory = eventType {
                Text("Re-Live your Moments ✨")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .listSectionSeparator(.hidden)
            }

            ForEach(filteredEvents) { event in
                EventCard(type: eventType,
                          event: event)
                    .listRowSeparator(.hidden)
            }
//            .onDelete { indexSet in
//                vm.deleteItem(at: indexSet)
//            }
        }
        .listStyle(.plain)
        .searchable(text: $searchedEvent,
                    tokens: $tokens,
                    placement: .toolbar,
                    prompt: "Search an event") { token in
            switch token {
            case .performer(let name):
                Label(name.capitalized,
                      systemImage: "person.crop.circle")
            case .place(let city):
                Label(city.capitalized,
                      systemImage: "pin.circle")
            }
        }
        .searchSuggestions {
            topHits()
            suggestions()
        }
        .navigationDestination(for: Event.self) { event in
            EventView(event: event)
        }
    }
    
    @ViewBuilder
    private func topHits() -> some View {
        if !searchedEvent.isEmpty && !filteredEvents.isEmpty {
            Section("Top Hits") {
                ForEach(filteredEvents) { event in
                    EventCard(type: eventType,
                              event: event)
                }
                .listRowSeparator(.hidden)
            }
        }
    }
    
    @ViewBuilder
    private func suggestions() -> some View {
        let performers = makeSuggestions(by: \.performer)
        let places = makeSuggestions(by: \.place)
        
        if !searchedEvent.isEmpty && (!performers.isEmpty || !places.isEmpty) {
            Section("Suggestions") {
                ForEach(performers, id: \.self) { performer in
                    Label(performer, systemImage: "person.crop.circle")
                        .searchCompletion(MemorySearchToken.performer(name: performer))
                }
                
                ForEach(places, id: \.self) { place in
                    Label(place, systemImage: "pin.circle")
                        .searchCompletion(MemorySearchToken.place(city: place))
                }
            }
        }
    }
    
    private var filteredEvents: [Event] {
        var filtered = events
        
        if !searchedEvent.isEmpty {
            filtered = filtered.filter { event in
                event.performer.contains(searchedEvent) || event.place.contains(searchedEvent)
            }
        }
        
        return filtered.filter { event in
            tokens.allSatisfy { token in
                switch token {
                case .performer(let name):
                    return event.performer.contains(name)
                case .place(let city):
                    return event.place.contains(city)
                }
            }
        }
    }
    
    private func makeSuggestions(by transform: (Event) -> String) -> [String] {
        events.map(transform)
            .filter { field in
                field.contains(searchedEvent)
            }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList(eventType: .memory, events: UpcomingEventVM(service: CloudKitService()).events)
    }
}
