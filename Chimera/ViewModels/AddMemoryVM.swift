//
//  AddMemoryVM.swift
//  Chimera
//
//  Created by Antonella Giugliano on 24/01/23.
//

import Foundation
import SwiftUI
import PhotosUI

class AddMemoryVM: ObservableObject{
    @Published var performer : String
    @Published var place : String
    @Published var date : Date
    @Published var imageDataCover: Data?
    @Published var mediaMemos: [MediaMemo]
    @Published var photoPickerItem: [PhotosPickerItem]
    @Published var photoPickerItemCover: [PhotosPickerItem]
    @Published var vocalMemos: [VocalMemo]
    @Published var textMemos: [String]
    
    init(event: Event?) {
        
        self.mediaMemos = []
        self.photoPickerItem = []
        self.photoPickerItemCover = []
        self.vocalMemos = []
        self.textMemos = []
        
        if let event {
            self.performer = event.performer
            self.place = event.place
            self.date = event.date

            self.imageDataCover = loadImageFromURL(url: event.image)
        } else {
            self.performer = ""
            self.place = ""
            self.date = Date()
        }
    }
    
    private func loadImageFromURL(url: String) -> Data? {
        let url = URL(string: url)
        if let url {
            let coverData  = try? Data(contentsOf: url)
            return coverData
        }
        return nil
    }
    
    func loadCover(_ photos: [PhotosPickerItem]) {
        imageDataCover = nil
        Task { @MainActor in
            for photo in photos {
                guard let image = try? await photo.loadTransferable(type: Data.self) else { return }
                imageDataCover = image
            }
        }
    }
    
    func loadImage(_ photos: [PhotosPickerItem]) {
        mediaMemos = []
        Task { @MainActor in
            for photo in photos {
                guard let mediaTypes = photo.supportedContentTypes.first,
                        var media = try? await photo.loadTransferable(type: MediaMemo.self) else { return }
                let isVideo = mediaTypes.preferredMIMEType?.split(separator: "/")[0] == "video"
                media.isVideo = isVideo
                mediaMemos.append(media)
            }
        }
    }
    
    func addEvent(eventsViewModel: EventVM) {
        eventsViewModel.events.append(
            Event(performer: performer,
                  place: place,
                  date: date,
                  image: "",
                  imageData: imageDataCover,
                  isMemory: true,
                  textMemos: textMemos,
                  vocalMemos: vocalMemos,
                  mediaMemos: mediaMemos)
        )
        resetProperties()
    }
    
    var isFormValid: Bool {
        !performer.isEmpty && !place.isEmpty && imageDataCover != nil
    }
    
    private func resetProperties() {
        performer = ""
        place = ""
        date = Date.now
        mediaMemos = []
        photoPickerItem = []
        imageDataCover = nil
    }
    
    func deleteMediaFiles() {
        for memo in mediaMemos {
            do {
                try FileManager.default.removeItem(at: memo.url)
            } catch {
                debugPrint(error)
            }
        }
        resetProperties()
    }
}
