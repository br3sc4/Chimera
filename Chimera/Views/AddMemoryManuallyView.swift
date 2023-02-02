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
    private var event : Event?
    @ObservedObject private var vm : AddMemoryVM
    
    init(event:Event?) {
        self.vm = AddMemoryVM(event: event)
    }
    
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
                DatePicker(selection: $vm.date, in: Date.now..., displayedComponents: .date) {
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
                        TextualMemosView(addMemoryVM: vm)
                    } label: {
                        AddMemorySectionRow(imageIcon: "note.text", memoName: "Textual Memos")
                    }
                    
                    NavigationLink {
                        MediaMemosView(addMemoryVM: vm)
                    } label: {
                        AddMemorySectionRow(imageIcon: "photo.fill", memoName: "Media Memos")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    vm.deleteMediaFiles()
                    dismiss()
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    vm.addEvent(eventsViewModel: eventVM)
                    dismiss()
                    dismiss()
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
        AddMemoryManuallyView(event:
                                Event(
                                    performer: "Imagine Dragons",
                                    place: "Munich",
                                    date: {
                                        var components = DateComponents()
                                        components.year = 2022
                                        components.month = 11
                                        components.day = 25
                                        return components.date ?? Date.now
                                    }(),
                                    image: "event1",
                                    isMemory: true, textMemos: [
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                                        "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur",
                                        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo"],
                                    vocalMemos: [
                                        VocalMemo(title: "Audio 1",
                                                  urlString: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"),
                                        VocalMemo(title: "Audio 2",
                                                  urlString: "data for audio 2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"),
                                        VocalMemo(title: "Audio 3",
                                                  urlString: "data for audio 3 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"),
                                    ]))
    }
}
