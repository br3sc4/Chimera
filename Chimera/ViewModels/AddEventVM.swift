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
    
    private let service: CloudKitService
    
    init(service: CloudKitService) {
        self.service = service
    }
    
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
//            eventsViewModel.events.append(Event(performer: performer, place: place, date: date, image: "imgforappending", isMemory: false))
            guard let event: Event = Event(performer: performer, place: place, date: date, isMemory: false) else { return }//Event = Event(performer: performer, place: place, date: date, isMemory: false)
            
            Task {
                
                try await service.add(item: event)
            }
            resetProperties()
            print("here")
        } else {
            
//            eventsViewModel.events.append(Event(performer: performer, place: place, date: date, image: "", isMemory: false))
            
            guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("house.jpg") else { return }
            do {
                try imageData[0].write(to: url)
                guard let event: Event = Event(performer: performer, place: place, date: date, cover: url, isMemory: false) else { return }
               
                Task {
                    
                    try await service.add(item: event)
                }
            } catch {
                print(error)
            }
            
            resetProperties()
            print("or here")
        }
    }
    
    func resetProperties() {
        performer = ""
        place = ""
        date = Date.now
        imageData = []
        photoPickerItem = []
    }
    
    
}
