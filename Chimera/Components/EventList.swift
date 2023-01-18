//
//  EventList.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct EventList: View {
    @State private var searchedMemory: String = ""
    @State private var tokens: [MemorySearchToken] = []
    
    private var memoryAttributed: AttributedString {
        var attributedString = AttributedString(stringLiteral: searchedMemory)
        attributedString.font = .body.bold()
        return attributedString
    }
    
    private var filteredEvents: [Event] {
        return events.filter { event in
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
        .searchable(text: $searchedMemory, tokens: $tokens, placement: .toolbar, prompt: "Search an event") { token in
            switch token {
            case .performer(let name):
                Label(name.capitalized, systemImage: "person.crop.circle")
            case .place(let city):
                Label(city.capitalized, systemImage: "pin.circle")
            }
        }
        .searchSuggestions {
            if !searchedMemory.isEmpty {
                Section("Top Hits") {
                    ForEach(filteredEvents) { event in
                        EventCard(image: event.image,
                                  performer: event.performer,
                                  date: event.date,
                                  place: event.place)
                    }
                }
            }
            
            if !searchedMemory.isEmpty {
                Section("Suggestions") {
                    Text("Performer contains: \(memoryAttributed)")
                        .searchCompletion(MemorySearchToken.performer(name: searchedMemory))
                    
                    Text("Place contains: \(memoryAttributed)")
                        .searchCompletion(MemorySearchToken.place(city: searchedMemory))
                }
            }
        }
        .onSubmit(of: .search) {
            print(searchedMemory)
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}
