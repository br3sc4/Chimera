//
//  EventCard.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct EventCard: View {
    let type: EventTypes
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            if event.imageData == nil {
                Image(event.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 136)
                    .cornerRadius(24)
            } else {
                if let data = event.imageData, let uiImage = UIImage(data: data){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 136)
                        .cornerRadius(24)
                }
            }
            
            switch type {
            case .memory:
                NavigationLink(value: event) {
                    Text(event.performer.capitalized)
                        .foregroundColor(.primary)
                }
            case .upcoming:
                Text(event.performer.capitalized)
                    .foregroundColor(.primary)
            }
            
            HStack{
                Text(event.date.formatted(date: .numeric, time: .omitted))
                    .foregroundColor(.secondary)
                Text(event.place.capitalized)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(type: .memory,
                  event: EventVM().events[0])
        
        EventCard(type: .upcoming,
                  event: EventVM().events[0])
    }
}
