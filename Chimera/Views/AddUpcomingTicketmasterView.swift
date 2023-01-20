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
    
    @State private var searchQuery = ""
    
    @State private var date = Date()
    @State private var locale: String = "IT"
    
    
    
    
    var searchResults: [Event] {
        if searchQuery.isEmpty {
            return [vm.events[0], vm.events[3]]
        } else {
            return vm.events.filter { $0.performer.localizedCaseInsensitiveContains(searchQuery)}
        }
    }
    
    
    var body: some View {
        
        VStack {
            HStack {
                DatePicker("Event Date", selection: $date, displayedComponents: .date)
                Spacer()
                Picker("Country Event", selection: $locale) {
                    ForEach(NSLocale.locales()) { locale in
                        
                        Text("\(locale.countryName) - \(locale.countryCode)")
                            .tag(locale.countryCode)
                    }
                }
//                .onChange(of: locale) { newValue in
//                    print(locale)
//                }
            }
            .padding()
            
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
            }
            .searchable(text: $searchQuery, placement:
                .navigationBarDrawer(displayMode: .always))
        }

    }
}

struct AddUpcomingTicketmasterView_Previews: PreviewProvider {
    static var previews: some View {
        AddUpcomingTicketmasterView().environmentObject(EventVM())
    }
}
