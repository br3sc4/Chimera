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
    @Published var performer = ""
    @Published var place = ""
    @Published var date = Date.now
    @Published var imageDataCover: Data?
    @Published var mediaMemo: [MediaMemo<Data>] = []
    @Published var photoPickerItem: [PhotosPickerItem] = []
    @Published var photoPickerItemCover: [PhotosPickerItem] = []
    @Published var vocalMemos: [VocalMemo] = []
    @Published var textMemos: [String] = []
    @Published var mediaMemos: [MediaType] = []
    
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
        mediaMemo = []
        Task { @MainActor in
            for photo in photos {
                guard let mediaTypes = photo.supportedContentTypes.first,
                        let image = try? await photo.loadTransferable(type: Data.self) else { return }
                let isVideo = mediaTypes.preferredMIMEType?.split(separator: "/")[0] == "video"
                mediaMemo.append(MediaMemo(content: image, isVideo: isVideo))
            }
        }
    }
    
    func addEvent(eventsViewModel: EventVM) {
        eventsViewModel.events.append(
            Event(performer: performer,
                  place: place,
                  date: date,
                  image: "",
                  textMemos: textMemos,
                  vocalMemos: vocalMemos,
                  imageData: imageDataCover,
                  mediaMemos: mediaMemos)
        )
        resetProperties()
    }
    
    func resetProperties() {
        performer = ""
        place = ""
        date = Date.now
        mediaMemo = []
        photoPickerItem = []
    }
    
}
