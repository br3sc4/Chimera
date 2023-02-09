//
//  AddMemoryManuallyView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 24/01/23.
//

import SwiftUI
import PhotosUI

struct AddMemoryManuallyView: View {
    @FocusState private var focusedField: FocusedFields?
    @Environment(\.dismiss) private var dismiss: DismissAction
    @EnvironmentObject private var eventVM: EventVM
    @EnvironmentObject private var vm: AddMemoryVM
    
    var body: some View {
        Form {
            Section {
                ZStack {
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
                    .focused($focusedField, equals: .performer)
                TextField("Place of the Event", text: $vm.place)
                    .focused($focusedField, equals: .place)
                DatePicker(selection: $vm.date, in: ...Date.now, displayedComponents: .date) {
                    Text("Date of the Event")
                }
            }
            Section{
                List{
                    NavigationLink {
                        RecorderView()
                    } label: {
                        AddMemorySectionRow(imageIcon: "mic.fill", memoName: "Vocal Memos")
                    }
                    
                    NavigationLink {
                        TextualMemosView()
                    } label: {
                        AddMemorySectionRow(imageIcon: "note.text", memoName: "Textual Memos")
                    }
                    
                    NavigationLink {
                        MediaMemosView()
                    } label: {
                        AddMemorySectionRow(imageIcon: "photo.fill", memoName: "Media Memos")
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    vm.deleteMediaFiles()
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    Task {
                        guard let event = await vm.addEvent() else { return }
                        eventVM.events.append(event)
                        dismiss()
                    }
                } label: {
                    Text("Done")
                }
                .disabled(!vm.isFormValid)
            }
        }
    }
    
}

extension AddMemoryManuallyView {
    private enum FocusedFields: Hashable {
        case performer, place
    }
}

struct AddMemoryManuallyView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoryManuallyView()
            .environmentObject(AddMemoryVM(service: CloudKitService()))
    }
}
