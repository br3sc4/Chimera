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
    @EnvironmentObject var vm: AddMemoryVM
    
    var body: some View {
        Form {
            Section{
                ZStack{
                    if vm.imageDataCover == nil {
                        Image("event1")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 136)
                            .cornerRadius(24)
                            .padding(.horizontal)
                    } else {
                        if let pickedData = vm.imageDataCover,
                            let uiImage = UIImage(data: pickedData) {
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
                    
                    PhotosPicker(vm.photoPickerItemCover.isEmpty ? "Select a Cover" : "Edit the Cover",
                                 selection: $vm.photoPickerItemCover,
                                 maxSelectionCount: 1,
                                 matching: .images)
                    .onChange(of: vm.photoPickerItemCover, perform: vm.loadCover)
                    .foregroundColor(.accentColor)
                }
            }
            .listRowBackground(Color.clear)
            .padding(.top)
            
            Section {
                TextField("Name of Performer", text: $vm.performer)
                TextField("Place of the Event", text: $vm.place)
                DatePicker(selection: $vm.date, in: Date.now..., displayedComponents: .date) {
                    Text("Date of the Event")
                }
            }
            Section{
                List{
                    NavigationLink(destination: {RecorderView()}, label: {AddMemorySectionRow(imageIcon: "mic.fill", memoName: "Vocal Memos")})
                    NavigationLink(destination: {TextualMemosView()}, label: {AddMemorySectionRow(imageIcon: "note.text", memoName: "Textual Memos")})
                    NavigationLink(destination: {MediaMemosView()}, label: {AddMemorySectionRow(imageIcon: "photo.fill", memoName: "Media Memos")})
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                }
            }
        }
    }
    
}

struct AddMemoryManuallyView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoryManuallyView().environmentObject(AddMemoryVM())
    }
}
