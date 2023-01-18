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
    
    private var memoryAttributed: AttributedString {
        var attributedString = AttributedString(stringLiteral: searchedEvent)
        attributedString.font = .body.bold()
        return attributedString
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
    
    var body: some View {
        List {
            Text("Re-Live your Moments ✨")
                .font(.title3)
                .fontWeight(.semibold)
                .listSectionSeparator(.hidden)
            
            ForEach(filteredEvents) { event in
                NavigationLink {
                    EventView(event: event)
                } label: {
                    EventCard(image: event.image,
                              performer: event.performer,
                              date: event.date,
                              place: event.place)
                }
                .foregroundColor(.clear)
                .listRowInsets(EdgeInsets(top: 11, leading: 20, bottom: 11, trailing: 5))
                .listRowSeparator(.hidden)
                .listRowBackground(Color(uiColor: .systemBackground))
            }
        }
        .listStyle(.plain)
        .searchable(text: $searchedEvent, tokens: $tokens, placement: .toolbar, prompt: "Search an event") { token in
            switch token {
            case .performer(let name):
                Label(name.capitalized, systemImage: "person.crop.circle")
            case .place(let city):
                Label(city.capitalized, systemImage: "pin.circle")
            }
        }
        .searchSuggestions {
            if !searchedEvent.isEmpty && !filteredEvents.isEmpty {
                Section("Top Hits") {
                    ForEach(filteredEvents) { event in
                        EventCard(image: event.image,
                                  performer: event.performer,
                                  date: event.date,
                                  place: event.place)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            
            if !searchedEvent.isEmpty {
                Section("Suggestions") {
                    Text("Performer contains: \(memoryAttributed)")
                        .searchCompletion(MemorySearchToken.performer(name: searchedEvent))
                    
                    Text("Place contains: \(memoryAttributed)")
                        .searchCompletion(MemorySearchToken.place(city: searchedEvent))
                }
            }
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}
