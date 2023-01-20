//
//  TicketMasterModel.swift
//  Chimera
//
//  Created by Simon Bestler on 18.01.23.
//

import Foundation


// MARK: - TicketMasterAPI
struct TicketMasterAPI: Codable {
    let embedded: TicketMasterAPIEmbedded
    let page: Page

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case page
    }
}

// MARK: - TicketMasterAPIEmbedded
struct TicketMasterAPIEmbedded: Codable {
    let events: [TMEvent]
}

// MARK: - Event
struct TMEvent: Codable {
    let name, type, id: String
    let url: String
    let locale: String
    let images: [TMImage]
    let dates: Dates
    let embedded: EventEmbedded

    enum CodingKeys: String, CodingKey {
        case name, type, id, url, locale, images, dates
        case embedded = "_embedded"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let start: Start
    let timezone: String
}

// MARK: - Start
struct Start: Codable {
    let localDate, localTime: String
    let dateTime: Date
}

// MARK: - EventEmbedded
struct EventEmbedded: Codable {
    let venues: [Venue]
    let attractions: [Attraction]
}

// MARK: - Venue
struct Venue: Codable {
    let name, type, id: String
    let test: Bool
    let locale, postalCode: String
    let city: City
    let country: Country
    let location: Location
}

struct Attraction: Codable {
    let name, type, id, locale, url : String
}

// MARK: - City
struct City: Codable {
    let name: String
}

// MARK: - Country
struct Country: Codable {
    let name, countryCode: String
}

// MARK: - Location
struct Location: Codable {
    let longitude, latitude: String
}

// MARK: - Image
struct TMImage: Codable {
    let ratio: String
    let url: String
    let width, height: Int
}

// MARK: - Page
struct Page: Codable {
    let size, totalElements, totalPages, number: Int
}
