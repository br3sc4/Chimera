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
    
    private var filteredMemories: [Event] {
        if searchedMemory.isEmpty {
            return events
        } else {
            return events.filter { event in
                event.performer.contains(searchedMemory)
            }
        }
    }
    
    var body: some View {
        List {
            Text("Re-Live your Moments ✨")
                .font(.title3)
                .fontWeight(.semibold)
                .listSectionSeparator(.hidden)
            
            ForEach(filteredMemories) { event in
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
            Label(token.rawValue.capitalized, systemImage: "person").tag(token)
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
