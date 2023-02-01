//
//  EventVM.swift
//  Chimera
//
//  Created by Antonella Giugliano on 18/01/23.
//

import Foundation

class EventVM: ObservableObject {
    
    @Published var events = [
        Event(
            performer: "Imagine Dragons",
            place: "Munich",
            date: {
                var components = DateComponents()
                components.year = 2022
                components.month = 11
                components.day = 25
                return components.date ?? Date.now
            }(),
            image: "event1",
            isMemory: true, textMemos: [
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
            date: {
                var components = DateComponents()
                components.year = 2019
                components.month = 7
                components.day = 30
                return components.date ?? Date.now
            }(),
            image: "event2",
            isMemory: true, textMemos: [
                "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo"],
            vocalMemos: [
                VocalMemo(title: "Audio 1",
                          urlString: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur"),
                VocalMemo(title: "Audio 2",
                          urlString: "data for audio 2 Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur"),
                VocalMemo(title: "Audio 3",
                          urlString: "data for audio 3 Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur"),
            ]
        ),
        Event(
            performer: "Bon Iver",
            place: "Milan",
            date: {
                var components = DateComponents()
                components.year = 2022
                components.month = 11
                components.day = 8
                return components.date ?? Date.now
            }(),
            image: "event3", isMemory: true
        ),
        Event(
            performer: "Imagine Dragons",
            place: "Munich",
            date: {
                var components = DateComponents()
                components.year = 2022
                components.month = 11
                components.day = 25
                return components.date ?? Date.now
            }(),
            image: "event1",
            isMemory: false, textMemos: [
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
            ])
    ]
    
}
