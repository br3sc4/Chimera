//
//  EventCard.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct EventCard: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading){
            
            Image(event.image)
                .resizable()
                .scaledToFill()
                .frame(height: 136)
                .cornerRadius(24)
            
            NavigationLink(value: event) {
                Text(event.performer.capitalized)
                    .foregroundColor(.primary)
            }
            
            HStack{
                Text(event.date)
                    .foregroundColor(.secondary)
                Text(event.place.capitalized)
                    .foregroundColor(.secondary)
            }
            
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(event: events[0])
    }
}
