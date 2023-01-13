//
//  MediaType.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 13/01/23.
//

import Foundation
import CoreGraphics

enum MediaType {
    case image(name: String), video(duration: Double, thumbnail: CGImage? = nil)
}
