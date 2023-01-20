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
//    @State private var searchQuery = ""
    @State var performer = ""
    @State var date = ""
    @State var place = ""
    @State var image: PhotosPickerItem?
//    var searchResults: [Event] {
//        if searchQuery.isEmpty {
//            return [vm.events[0], vm.events[3]]
//        } else {
//            return vm.events.filter { $0.performer.localizedCaseInsensitiveContains(searchQuery)}
//        }
//    }
    var body: some View {
        NavigationStack{
            VStack(spacing: 4){
                if isViaTicketmaster{
                    AddUpcomingTicketmasterView().environmentObject(vm)
                }else{
                    
                    AddUpcomingManuallyView().environmentObject(vm)
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
//                ToolbarItem(placement: .confirmationAction) {
//                    Button(action: {
//                        vm.events.append(Event(performer: performer, place: place, date: date, image: "imgforappending"))
//                        dismiss()
//                    }, label: {
//                        Text("Done")
//                    })
//                }
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
