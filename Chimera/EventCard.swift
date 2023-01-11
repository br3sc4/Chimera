//
//  EventCard.swift
//  Chimera
//
//  Created by Antonella Giugliano on 11/01/23.
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
                .frame(width: 356, height: 136)
                .cornerRadius(24)
            
            Text(performer)
                .foregroundColor(.primary)
                .font(.system(size: 16))
            HStack{
                Text(date)
                    .foregroundColor(.secondary)
                    .font(.system(size: 16))
                Text(place)
                    .foregroundColor(.secondary)
                    .font(.system(size: 16))
            }
            
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(image: "event1", performer: "Name of Performer", date: "Date", place: "Place")
    }
}
