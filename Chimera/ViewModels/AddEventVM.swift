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
    @Published var images: [Data] = []
    @Published var photoPickerItem: PhotosPickerItem?
    
    
    func loadImages(_ photos: [PhotosPickerItem]) {
        Task { @MainActor in
            for photo in photos {
                guard let image = try? await photo.loadTransferable(type: Data.self) else { return }
                images.append(image)
            }
        }
    }
    
}
