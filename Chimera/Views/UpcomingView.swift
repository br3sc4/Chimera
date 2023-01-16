//
//  UpcomingView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 16/01/23.
//

import SwiftUI

struct UpcomingView: View {
    @State var isShowingAddUpcoming = false
    @State private var searchQuery = ""
    var searchResults: [Event] {
        if searchQuery.isEmpty {
            return events
        } else {
            return events.filter { $0.performer.localizedCaseInsensitiveContains(searchQuery)}
        }
    }
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                ForEach(searchResults){ x in
                    NavigationLink(destination: EventView(event: x), label: {
                        EventCard(image: x.image, performer: x.performer, date: x.date, place: x.place)
                            .padding(.vertical)
                    })
                }
                .padding(.horizontal)
            }
            .navigationTitle("Upcomig Events")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingAddUpcoming.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }.sheet(isPresented: $isShowingAddUpcoming, content: {AddUpcomingView()})
            .searchable(text: $searchQuery, placement: .automatic)
        }
    }
}


struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
    }
}
