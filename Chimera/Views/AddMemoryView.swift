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
    @EnvironmentObject var vm: EventVM
    @State var isFromUpcoming = true
    var body: some View {
        NavigationStack{
            VStack(spacing: 4){
                if isFromUpcoming{
                    AddMemoryUpcomingEventsView()
                }else{
                    
                    AddMemoryManuallyView()
                }
            }
            .navigationTitle("Add a new Memory")
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
                    Picker("", selection: $isFromUpcoming){
                        Text("Your Upcoming Events").tag(true)
                        Text("Manually").tag(false)
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
}

struct AddMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoryView().environmentObject(EventVM())
    }
}
