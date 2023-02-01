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
    @Published var date = Date.now
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
    
    func addEvent(upcomingVM: UpcomingEventVM){
        if photoPickerItem.isEmpty {
            upcomingVM.events.append(Event(performer: performer, place: place, date: date, image: "imgforappending", isMemory: false))
            resetProperties()
            print("here")
        } else {
            upcomingVM.events.append(Event(performer: performer, place: place, date: date, image: "", imageData: imageData[0], isMemory: false))
            resetProperties()
            print("or here")
        }
    }
    
    func resetProperties(){
        performer = ""
        place = ""
        date = Date.now
        imageData = []
        photoPickerItem = []
    }
}
