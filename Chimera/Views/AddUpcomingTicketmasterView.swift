//
//  AddUpcomingTicketmasterView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 19/01/23.
//

import SwiftUI

struct AddUpcomingTicketmasterView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: UpcomingEventVM
    @StateObject private var ticketMasterVm = CreateEventApiViewModel()
    
    var searchResults: [Event] {
        if ticketMasterVm.searchQuery.isEmpty {
            return [vm.events[0], vm.events[3]]
        } else {
            return vm.events.filter { $0.performer.localizedCaseInsensitiveContains(ticketMasterVm.searchQuery)}
        }
    }
    
    var body: some View {
        
        VStack {
            VStack {
                Toggle("Specify Date", isOn: $ticketMasterVm.isUseDate)
                if ticketMasterVm.isUseDate {
                    DatePicker("Event Date", selection: $ticketMasterVm.date, displayedComponents: .date)
                    Divider()
                }
                HStack {
                    Text("Country")
                    Spacer()
                    Picker("Country Event", selection: $ticketMasterVm.locale) {
                        ForEach(NSLocale.locales()) { locale in
                            
                            Text("\(locale.countryName) - \(locale.countryCode)")
                                .tag(locale.countryCode)
                        }
                    }
                }
            }
            .alert(isPresented: $ticketMasterVm.isError){
                Alert(title: Text("Nothing found"),
                      message: Text("Unfortunately we found nothing corresponding to your search!")
                )
            }
            .padding()
            
            ScrollView{
                ForEach(ticketMasterVm.events){ result in
                    Button(action: {
                        if !ticketMasterVm.checkIfEventAlreadyExists(events: vm.events, searchEvent: result){
                            Task {
                                let eventWithPreview = await ticketMasterVm.eventWithPreview(result)
                                vm.events.append(eventWithPreview)
                            }
                        }

                    }, label: {
                        HStack{
                            Spacer()
                            if ticketMasterVm.checkIfEventAlreadyExists(events: vm.events, searchEvent: result){
                                Image(systemName: "checkmark")
                                    .fontWeight(.semibold)
                            } else {
                                Image(systemName: "plus")
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                            AddUpcomingEventCard(image: result.image,
                                                 performer: result.performer,
                                                 date: result.date,
                                                 place: result.place)
                                .padding(.vertical)
                        }
                    }
                    )
                    
                    .padding(.horizontal)
                }
            }
            .searchable(text: $ticketMasterVm.searchQuery, placement:
                .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search, {
                Task{
                    await ticketMasterVm.getEvents()
                }
            })
        }.toolbar{
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                }
            }
        }
        .alert(isPresented: $ticketMasterVm.isError) {
            Alert(title: Text("Nothing found"),
                  message: Text("Unfortunately we found nothing corresponding to your search!")
            )
        }
    }
}

struct AddUpcomingTicketmasterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddUpcomingTicketmasterView()
                .environmentObject(UpcomingEventVM())
        }
    }
}
