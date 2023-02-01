//
//  AddUpcomingView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 16/01/23.
//

import SwiftUI
import PhotosUI

struct AddUpcomingView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: UpcomingEventVM
    @State private var isViaTicketmaster = true
    @State private var performer = ""
    @State private var date = ""
    @State private var place = ""
    @State private var image: PhotosPickerItem?
    
    init(performer: String = "",
         date: String = "",
         place: String = "",
         image: PhotosPickerItem? = nil) {
        self.isViaTicketmaster = isViaTicketmaster
        self.performer = performer
        self.date = date
        self.place = place
        self.image = image
    }
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 4){
                if isViaTicketmaster {
                    AddUpcomingTicketmasterView()
                } else {
                    AddUpcomingManuallyView()
                }
            }
            .navigationTitle(isViaTicketmaster ? "Search a new Event" : "Add a new Event")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
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
    static var previews: some View {
        AddUpcomingView(performer: "Name of Performer", date: "Date", place: "Place").environmentObject(EventVM())
    }
}
