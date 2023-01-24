//
//  AddMemoryManuallyView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 24/01/23.
//

import SwiftUI
import PhotosUI

struct AddMemoryManuallyView: View {
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
            Section{
                List{
                    NavigationLink(destination: {RecorderView()}, label: {AddMemorySectionRow(imageIcon: "mic.fill", memoName: "Vocal Memos")})
                    NavigationLink(destination: {ContentView()}, label: {AddMemorySectionRow(imageIcon: "note.text", memoName: "Textual Memos")})
                    NavigationLink(destination: {ContentView()}, label: {AddMemorySectionRow(imageIcon: "photo.fill", memoName: "Media Memos")})
                }
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

struct AddMemoryManuallyView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoryManuallyView().environmentObject(EventVM()).environmentObject(AddEventVM())
    }
}
