//
//  EventModel.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import Foundation

struct Event: Identifiable, Hashable {
    let id = UUID()
    var performer: String
    var place: String
    var date: String
    var image: String
    var textMemos: [String]?
    var vocalMemos: [VocalMemo]?
    var imageData: Data?
    var mediaMemos: [MediaType]?
}

struct VocalMemo: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var urlString: String
}
