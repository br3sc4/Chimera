//
//  AddUpcomingView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 16/01/23.
//

import SwiftUI

struct AddUpcomingView: View {
    @Environment(\.dismiss) var dismiss
    @State var isViaTicketmaster = true
    @State private var searchQuery = ""
    var searchResults: [Event] {
        if searchQuery.isEmpty {
            return [events[0], events[3]]
        } else {
            return events.filter { $0.performer.localizedCaseInsensitiveContains(searchQuery)}
        }
    }
    var body: some View {
        NavigationStack{
            VStack{
                Picker("", selection: $isViaTicketmaster){
                    Text("Ticketmaster").tag(true)
                    Text("Manually").tag(false)
                }
                .pickerStyle(.segmented)
                .padding()
                
                if isViaTicketmaster{
                    //                    NavigationView{
                    ScrollView{
                        ForEach(searchResults){ result in
                            Button(action: {
                                
                            }, label: {
                                HStack{
                                    Spacer()
                                    Image(systemName: "plus")
                                        .fontWeight(.semibold)
                                    //                                        .font(.system(size: 18))
                                    Spacer()
                                    AddUpcomingEventCard(image: result.image, performer: result.performer, date: result.date, place: result.place)
                                        .padding(.vertical)
                                }
                            }
                            )
                        }
                            .padding(.horizontal)
                        //                        }
                    }.searchable(text: $searchQuery)
                }else {
                    Text("Manually adding")
                    Spacer()
                }
            }
            .navigationTitle("Add a new Upcoming Gig")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                    }, label: {
                        Text("Done")
                    })
                }
            }
        }
    }
}

struct AddUpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        AddUpcomingView()
    }
}
