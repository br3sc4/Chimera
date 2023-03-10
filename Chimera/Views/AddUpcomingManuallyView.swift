//
//  AddUpcomingManuallyView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 19/01/23.
//

import SwiftUI
import PhotosUI

struct AddUpcomingManuallyView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var eventsVM: EventVM
    @EnvironmentObject var vm: AddEventVM
  
    var body: some View {
        Form {
            Section{
                ZStack{
                    if vm.imageData.isEmpty{
                        Image("event1")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 136)
                            .cornerRadius(24)
                            .padding(.horizontal)
                    }else{
                        if let pickedData = vm.imageData[0], let uiImage = UIImage(data: pickedData){
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 136)
                                .cornerRadius(24)
                                .padding(.horizontal)
                        }
                    }
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(height: 136)
                        .opacity(0.75)
                        .cornerRadius(24)
                        .padding(.horizontal)
                    
                    PhotosPicker(vm.photoPickerItem.isEmpty ? "Select a Cover" : "Edit the Cover", selection: $vm.photoPickerItem, maxSelectionCount: 1, matching: .images)
                        .onChange(of: vm.photoPickerItem, perform: vm.loadImage)
                        .foregroundColor(.accentColor)
                }
            }
            .listRowBackground(Color.clear)
            .padding(.top)
            
            Section {
                TextField("Name of Performer", text: $vm.performer)
                TextField("Place of the Event", text: $vm.place)
                TextField("Date of the Event", text: $vm.date)
            }
            
        }.toolbar{
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    vm.addEvent(EventsViewModel: eventsVM)
                    dismiss()
                }, label: {
                    Text("Done")
                })
            }
        }
    }
    
}

struct AddUpcomingManuallyView_Previews: PreviewProvider {
    static var previews: some View {
        AddUpcomingManuallyView().environmentObject(EventVM()).environmentObject(AddEventVM())
    }
}
