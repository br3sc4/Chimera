//
//  UpcomingView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 16/01/23.
//

import SwiftUI

struct UpcomingView: View {
    @EnvironmentObject var vm: EventVM
    @State var isShowingAddUpcoming = false
    @State private var searchQuery = ""
    var searchResults: [Event] {
        if searchQuery.isEmpty {
            return vm.events
        } else {
            return vm.events.filter { $0.performer.localizedCaseInsensitiveContains(searchQuery)}
        }
    }

    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                ForEach(searchResults){ result in
                    NavigationLink(destination: EventView(event: result), label: {
                        EventCard(event: result)

                            .padding(.vertical)
                    })
                }
                .padding(.horizontal)
            }
            .navigationTitle("Upcoming Events")
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
        UpcomingView().environmentObject(EventVM())
    }
}
