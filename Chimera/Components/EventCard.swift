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
            if let url = event.cover, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 136)
                    .cornerRadius(24)
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
                  event: EventVM(service: CloudKitService()).events[0])
        
        EventCard(type: .upcoming,
                  event: EventVM(service: CloudKitService()).events[0])
    }
}
