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
    @State var pickedImage: PhotosPickerItem?
    @State private var pickedData: Data?
    var body: some View {
        Form {
            Section{
                ZStack{
                    if pickedImage == nil {
                        Image("event1")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 136)
                            .cornerRadius(24)
                            .padding(.horizontal)
                    }else{
                        if let pickedData, let uiImage = UIImage(data: pickedData){
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
                    
                PhotosPicker(pickedImage == nil ? "Select a Cover" : "Edit the Cover", selection: $pickedImage, matching: .images)
                        .onChange(of: pickedImage) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            pickedData = data
                        }
                    }
                }
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
                    if pickedData == nil{
                        eventsVM.events.append(Event(performer: vm.performer, place: vm.place, date: vm.date, image: "imgforappending"))
                    }
                    else{
                        eventsVM.events.append(Event(performer: vm.performer, place: vm.place, date: vm.date, image: "", imageData: pickedData))
                    }
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
