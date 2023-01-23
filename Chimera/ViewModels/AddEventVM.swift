//
//  AddEventVM.swift
//  Chimera
//
//  Created by Antonella Giugliano on 19/01/23.
//

import Foundation
import SwiftUI
import PhotosUI


class AddEventVM: ObservableObject{
    @Published var performer = ""
    @Published var place = ""
    @Published var date = ""
    @Published var imageData: [Data] = []
    @Published var photoPickerItem: [PhotosPickerItem] = []
    
    
    func loadImage(_ photos: [PhotosPickerItem]) {
        imageData = []
        Task { @MainActor in
            for photo in photos {
                guard let image = try? await photo.loadTransferable(type: Data.self) else { return }
                imageData.append(image)
            }
        }
    }
    
    func addEvent(EventsViewModel: EventVM){
        if photoPickerItem.isEmpty{
            EventsViewModel.events.append(Event(performer: performer, place: place, date: date, image: "imgforappending"))
            resetProperties()
            print("here")
        }
        else{
            EventsViewModel.events.append(Event(performer: performer, place: place, date: date, image: "", imageData: imageData[0]))
            resetProperties()
            print("or here")
        }
    }
    
    func resetProperties(){
        performer = ""
        place = ""
        date = ""
        imageData = []
        photoPickerItem = []
    }
}
