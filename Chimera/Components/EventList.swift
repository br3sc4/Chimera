//
//  EventList.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct EventList: View {
    
    var body: some View {
        List {
            Section("Re-Live your Moments ✨") {
                ForEach(events) { event in
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
            .headerProminence(.increased)
        }
        .listStyle(.plain)
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}
