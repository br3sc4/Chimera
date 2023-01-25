//
//  EventModel.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import Foundation

struct Event: Identifiable, Hashable {
    let id = UUID()
    let performer: String
    var place: String
    var date: Date
    var image: String
    var imageData: Data?
    var isMemory: Bool
    var textMemos: [String]?
    var vocalMemos: [VocalMemo]?
    var mediaMemos: [MediaType]?
}

struct VocalMemo: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var urlString: String
}
