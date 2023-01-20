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
    @Published var imageData: Data?

}
