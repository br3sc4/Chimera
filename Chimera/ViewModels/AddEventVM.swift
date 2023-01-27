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
            let event: Event = Event(performer: performer, place: place, date: date, isMemory: false)
            Task {
                
                try await service.add(item: event.record)
            }
            resetProperties()
            print("here")
        } else {
//            guard
//                let image = UIImage(named: "house"),
//                let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("house.jpg"),
//                let data = image.jpegData(compressionQuality: 1.0) else { return }
//            do {
//                try data.write(to: url)
//                guard let newFruit = FruitModel.init(name: name, imageURL: url) else { return }
//                CloudKitUtility.add(item: newFruit) { result in
//                    DispatchQueue.main.async {
//                        self.fetchItems()
//                    }
//                }
//            } catch let error {
//                print(error)
//            }
            
//            eventsViewModel.events.append(Event(performer: performer, place: place, date: date, image: "", isMemory: false))
            
            guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("house.jpg") else { return }
            do {
                try imageData[0].write(to: url)
                //let imageStringURL = try String(contentsOf: url)
                let event: Event = Event(performer: performer, place: place, date: date, cover: url, isMemory: false)
                Task {
                    
                    try await service.add(item: event.record)
                }
            } catch {
                print(error)
            }
            
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
