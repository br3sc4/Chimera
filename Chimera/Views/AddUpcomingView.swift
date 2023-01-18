//
//  AddUpcomingView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 16/01/23.
//

import SwiftUI
import PhotosUI

struct AddUpcomingView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: EventVM
    @State var isViaTicketmaster = true
    @State private var searchQuery = ""
    @State var performer = ""
    @State var date = ""
    @State var place = ""
    @State var image: PhotosPickerItem?
    var searchResults: [Event] {
        if searchQuery.isEmpty {
            return [vm.events[0], vm.events[3]]
        } else {
            return vm.events.filter { $0.performer.localizedCaseInsensitiveContains(searchQuery)}
        }
    }
    var body: some View {
        NavigationStack{
            VStack(spacing: 4){
                if isViaTicketmaster{
                    ScrollView{
                        ForEach(searchResults){ result in
                            Button(action: {
                                
                            }, label: {
                                HStack{
                                    Spacer()
                                    Image(systemName: "plus")
                                        .fontWeight(.semibold)
                                    Spacer()
                                    AddUpcomingEventCard(image: result.image, performer: result.performer, date: result.date, place: result.place)
                                        .padding(.vertical)
                                }
                            }
                            )
                            
                            .padding(.horizontal)
                        }
                    }.searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
                }else{
                    
                    Form{
                        
                        Section{
                            PhotosPicker(selection: $image, matching: .images) {
                                ZStack{
                                    Image("event1")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 136)
                                        .cornerRadius(24)
                                        .padding(.horizontal)
                                    
                                    Rectangle()
                                        .foregroundColor(.gray)
                                        .frame(height: 136)
                                        .opacity(0.5)
                                        .cornerRadius(24)
                                        .padding(.horizontal)
                                    
                                    Text(image == nil ? "Select a Cover" : "Edit the Cover")
                                        .foregroundColor(.accentColor)
                                }
                            }
                        }.listRowBackground(Color.clear)
                            .padding(.top)
                        
                        Section {
                            TextField("Name of Performer", text: $performer)
                            TextField("Place of the Event", text: $place)
                            TextField("Date of the Event", text: $date)
                        }
                    }
                }
            }
            .navigationTitle(isViaTicketmaster ? "Search a new Event" : "Add a new Event")
            .navigationBarTitleDisplayMode(.large)
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
                        vm.events.append(Event(performer: performer, place: place, date: date, image: "imgforappending"))
                        dismiss()
                    }, label: {
                        Text("Done")
                    })
                }
                ToolbarItem(placement: .principal) {
                    Picker("", selection: $isViaTicketmaster){
                        Text("Ticketmaster").tag(true)
                        Text("Manually").tag(false)
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
}

struct AddUpcomingView_Previews: PreviewProvider {
    @StateObject var vm = EventVM()
    static var previews: some View {
        AddUpcomingView(performer: "Name of Performer", date: "Date", place: "Place")
    }
}
