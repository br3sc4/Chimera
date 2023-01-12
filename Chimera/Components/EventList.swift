//
//  EventList.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct EventList: View {
    
    var body: some View {
        VStack(spacing:2){
            ForEach(events){
                event in
                NavigationLink(destination: EventView(event: event), label: {
                    EventCard(image: event.image, performer: event.performer, date: event.date, place: event.place)
                        .padding(.vertical)
                }
                )
            }
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}
