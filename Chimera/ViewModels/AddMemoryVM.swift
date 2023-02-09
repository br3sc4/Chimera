//
//  AddMemoryVM.swift
//  Chimera
//
//  Created by Antonella Giugliano on 24/01/23.
//

import Foundation
import SwiftUI
import PhotosUI
import CloudKit

class AddMemoryVM: ObservableObject{
    @Published var performer = ""
    @Published var place = ""
    @Published var date = Date.now
    @Published var imageDataCover: Data?
    @Published var mediaMemos: [MediaMemo] = []
    @Published var photoPickerItem: [PhotosPickerItem] = []
    @Published var photoPickerItemCover: [PhotosPickerItem] = []
    @Published var vocalMemos: [VocalMemo] = []
    @Published var textMemos: [TextMemoModel] = []
    
    
    private let service: CloudKitService
    
    init(service: CloudKitService) {
        self.service = service
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
                
                media.isVideo = mediaTypes.preferredMIMEType?.split(separator: "/")[0] == "video"
                if media.isVideo {
                    let ext = media.url.pathExtension
                    media.configureVideo(of: ext)
                }
                mediaMemos.append(media)
            }
        }
    }
    
    func addEvent() async -> Event? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("house.jpg") else { return nil }
        do {
            guard let imageDataCover else { return nil }
            try imageDataCover.write(to: url)
            guard let event: Event = Event(performer: performer, place: place, date: date, cover: url, isMemory: true) else { return nil }
            
                
            let record = try await service.add(item: event)
            guard let event = Event(record: record) else { return nil }
            print("1")
            print(mediaMemos)
            for memo in mediaMemos {
                print("2")
                guard let memo = MediaMemo(from: memo, referenceItem: event) else { return nil }
                print("3")
                debugPrint(memo)
                try await addRelationMedia(memo)
                
            }
            
            for memo in textMemos {
                guard let memo = TextMemoModel(text: memo.text, referenceItem: event) else { return nil }
                try await addRelationMedia(memo)
            }
            
            resetProperties()
            return event
        } catch {
            print(error)
        }
        
        resetProperties()
        return nil
    }
    
    var isFormValid: Bool {
        !performer.isEmpty && !place.isEmpty && imageDataCover != nil
    }
    
    private func resetProperties() {
        DispatchQueue.main.async {
            self.performer = ""
            self.place = ""
            self.date = Date.now
            self.mediaMemos = []
            self.photoPickerItem = []
            self.imageDataCover = nil
        }
       
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
    
    func addRelationMedia<T: CloudKitableProtocol>(_ media: T) async throws {
        print("addrelation \(media)")
//        guard let event = ] else { return }
//        guard let voiceMemo = VocalMemo(title: "Vocal 3", vocalURL: nil, referenceItem: events[0]) else { return }
        
        
            try await service.add(item: media)
    }
}
