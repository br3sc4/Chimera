//
//  AddUpcomingEventCard.swift
//  Chimera
//
//  Created by Antonella Giugliano on 16/01/23.
//

import SwiftUI

struct AddUpcomingEventCard: View {
    let image: String
    let performer: String
    let date: String
    let place: String
    
    var body: some View {
        HStack(alignment: .center){
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            Spacer()
            VStack(alignment: .leading, spacing: 5){
                Text(performer.capitalized)
                    .foregroundColor(.primary)
                HStack{
                    Text(date)
                        .foregroundColor(.secondary)
                    Text(place.capitalized)
                        .foregroundColor(.secondary)
                }
                Text(place.capitalized)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Spacer()
            
        }.padding(.horizontal)
    }
}

struct AddUpcomingEventCard_Previews: PreviewProvider {
    static var previews: some View {
        AddUpcomingEventCard(image: "event1", performer: "Name of Performer", date: "Date", place: "Place")
    }
}
