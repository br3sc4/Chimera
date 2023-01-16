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
}

struct VocalMemo: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var urlString: String
}


var events = [
    Event(
        performer: "Imagine Dragons",
        place: "Munich",
        date: "25-11-2022",
        image: "event1",
        textMemos: [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur",
    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo"],
        vocalMemos: [
            VocalMemo(title: "Audio 1",
                      urlString: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"),
            VocalMemo(title: "Audio 2",
                      urlString: "data for audio 2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"),
            VocalMemo(title: "Audio 3",
                      urlString: "data for audio 3 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"),
            ]),
    Event(
        performer: "Foo Fighters",
        place: "London",
        date: "30-07-2019",
        image: "event2",
        textMemos: [
    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo"],
        vocalMemos: [
            VocalMemo(title: "Audio 1",
                      urlString: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur"),
            VocalMemo(title: "Audio 2",
                       urlString: "data for audio 2 Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur"),
            VocalMemo(title: "Audio 3",
                      urlString: "data for audio 3 Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur"),
            ]),
    Event(
        performer: "Bon Iver",
        place: "Milan",
        date: "08-11-2022",
        image: "event3"
        ),
    Event(
        performer: "Imagine Dragons",
        place: "Munich",
        date: "25-11-2022",
        image: "event1",
        textMemos: [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur",
    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo"],
        VocalMemos: [
            VocalMemo(title: "Audio 1",
                      urlString: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"),
            VocalMemo(title: "Audio 2",
                      urlString: "data for audio 2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"),
            VocalMemo(title: "Audio 3",
                      urlString: "data for audio 3 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"),
            ])
]
