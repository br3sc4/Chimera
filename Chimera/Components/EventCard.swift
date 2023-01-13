//
//  EventCard.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct EventCard: View {
    
    let image: String
    let performer: String
    let date: String
    let place: String
    
    var body: some View {
        VStack(alignment: .leading){
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(height: 136)
                .cornerRadius(24)
            
            Text(performer.capitalized)
                .foregroundColor(.primary)
            HStack{
                Text(date)
                    .foregroundColor(.secondary)
                Text(place.capitalized)
                    .foregroundColor(.secondary)
            }
            
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(image: "event1", performer: "Name of Performer", date: "Date", place: "Place")
    }
}
