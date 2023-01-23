//
//  AddUpcomingTicketmasterView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 19/01/23.
//

import SwiftUI

struct AddUpcomingTicketmasterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: EventVM
    @StateObject var ticketMasterVm = CreateEventApiViewModel()
    
    
    //@State private var date = Date()
    //@State private var locale: String = "IT"
    
    
    
    
    var searchResults: [Event] {
        if ticketMasterVm.searchQuery.isEmpty {
            return [vm.events[0], vm.events[3]]
        } else {
            return vm.events.filter { $0.performer.localizedCaseInsensitiveContains(ticketMasterVm.searchQuery)}
        }
    }
    
    
    var body: some View {
        
        VStack {
            HStack {
                DatePicker("Event Date", selection: $ticketMasterVm.date, displayedComponents: .date)
                Spacer()
                Picker("Country Event", selection: $ticketMasterVm.locale) {
                    ForEach(NSLocale.locales()) { locale in
                        
                        Text("\(locale.countryName) - \(locale.countryCode)")
                            .tag(locale.countryCode)
                    }
                }
                //                .onChange(of: locale) { newValue in
                //                    print(locale)
                //                }
            }
            .alert(isPresented: $ticketMasterVm.isError){
                Alert(title: Text("API-Error"),
                      message: Text(ticketMasterVm.apiError ?? "Something went wrong!")
                )
            }
            .padding()

            
            ScrollView{
                ForEach(ticketMasterVm.events){ result in
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
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Done")
                })
            }
        }

    }
}

struct AddUpcomingTicketmasterView_Previews: PreviewProvider {
    static var previews: some View {
        AddUpcomingTicketmasterView().environmentObject(EventVM())
    }
}
