//
//  AddMemoryView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 24/01/23.
//

import SwiftUI
import PhotosUI

struct AddMemoryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var upcomingVM : UpcomingEventVM
    var body: some View {
        NavigationStack {
            NavigationLink{
                EditMemoryView(event: nil)
            }label: {
                HStack {
                    Image(systemName: "plus.circle")
                        .font(.largeTitle)
                    Text("Create new Memory")
                }
            }
            List{
                Text("Choose from your Upcoming")
                    .fontWeight(.bold)
                ForEach(upcomingVM.events) { event in
                    NavigationLink{
                        EditMemoryView(event: event)

                    }label: {
                        EventCard(type: .upcoming, event: event)
                    }
                }
                .listRowSeparator(.hidden)


            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }

    }
}

struct AddMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoryView()
            .environmentObject(EventVM())
            .environmentObject(UpcomingEventVM())
    }
}
