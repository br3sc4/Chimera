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
    @Published var mediaMemos: [MediaMemo] = []
    @Published var photoPickerItem: [PhotosPickerItem] = []
    @Published var photoPickerItemCover: [PhotosPickerItem] = []
    @Published var vocalMemos: [VocalMemo] = []
    @Published var textMemos: [String] = []
    
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
//        eventsViewModel.events.append(
//            Event(performer: performer,
//                  place: place,
//                  date: date,
//                  image: "",
//                  imageData: imageDataCover,
//                  isMemory: true,
//                  textMemos: textMemos,
//                  vocalMemos: vocalMemos,
//                  mediaMemos: mediaMemos)
//        )
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
