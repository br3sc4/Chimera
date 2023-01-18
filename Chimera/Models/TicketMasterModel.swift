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
    let links: AttractionLinks
    let page: Page

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case links = "_links"
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
    let test: Bool
    let url: String
    let locale: String
    let images: [TMImage]
    let sales: Sales
    let dates: Dates
    let classifications: [Classification]
    let links: EventLinks
    let embedded: EventEmbedded

    enum CodingKeys: String, CodingKey {
        case name, type, id, test, url, locale, images, sales, dates, classifications
        case links = "_links"
        case embedded = "_embedded"
    }
}

// MARK: - Classification
struct Classification: Codable {
    let primary: Bool
    let segment, genre, subGenre, type: Genre
    let subType: Genre
    let family: Bool
}

// MARK: - Genre
struct Genre: Codable {
    let id: String
}

// MARK: - Dates
struct Dates: Codable {
    let start: Start
    let timezone: String
    let status: Status
    let spanMultipleDays: Bool
}

// MARK: - Start
struct Start: Codable {
    let localDate, localTime: String
    let dateTime: Date
    let dateTBD, dateTBA, timeTBA, noSpecificTime: Bool
}

// MARK: - Status
struct Status: Codable {
    let code: String
}

// MARK: - EventEmbedded
struct EventEmbedded: Codable {
    let venues: [Venue]
    let attractions: [Attraction]
}

// MARK: - Attraction
struct Attraction: Codable {
    let name, type, id: String
    let test: Bool
    let url: String
    let locale: String
    let externalLinks: ExternalLinks
    let aliases: [String]
    let images: [TMImage]
    let classifications: [Classification]
    let upcomingEvents: AttractionUpcomingEvents
    let links: AttractionLinks

    enum CodingKeys: String, CodingKey {
        case name, type, id, test, url, locale, externalLinks, aliases, images, classifications, upcomingEvents
        case links = "_links"
    }
}

// MARK: - ExternalLinks
struct ExternalLinks: Codable {
    let youtube, twitter, itunes, lastfm: [Facebook]
    let facebook, wiki, spotify, instagram: [Facebook]
    let musicbrainz: [Genre]
    let homepage: [Facebook]
}

// MARK: - Facebook
struct Facebook: Codable {
    let url: String
}

// MARK: - TMImage
struct TMImage: Codable {
    let ratio: Ratio
    let url: String
    let width, height: Int
    let fallback: Bool
    let attribution: Attribution
}

enum Attribution: String, Codable {
    case imageSuppliedByLiveNation = "Image supplied by Live Nation."
}

enum Ratio: String, Codable {
    case the16_9 = "16_9"
    case the3_2 = "3_2"
    case the4_3 = "4_3"
}

// MARK: - AttractionLinks
struct AttractionLinks: Codable {
    let linksSelf: SelfElement

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfElement
struct SelfElement: Codable {
    let href: String
}

// MARK: - AttractionUpcomingEvents
struct AttractionUpcomingEvents: Codable {
    let total, mfxDk, mfxNl, ticketmaster: Int
    let filtered, mfxCh: Int

    enum CodingKeys: String, CodingKey {
        case total = "_total"
        case mfxDk = "mfx-dk"
        case mfxNl = "mfx-nl"
        case ticketmaster
        case filtered = "_filtered"
        case mfxCh = "mfx-ch"
    }
}

// MARK: - Venue
struct Venue: Codable {
    let name, type, id: String
    let test: Bool
    let locale, postalCode: String
    let city: City
    let country: Country
    let location: Location
    let upcomingEvents: VenueUpcomingEvents
    let links: AttractionLinks

    enum CodingKeys: String, CodingKey {
        case name, type, id, test, locale, postalCode, city, country, location, upcomingEvents
        case links = "_links"
    }
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

// MARK: - VenueUpcomingEvents
struct VenueUpcomingEvents: Codable {
    let total, filtered: Int

    enum CodingKeys: String, CodingKey {
        case total = "_total"
        case filtered = "_filtered"
    }
}

// MARK: - EventLinks
struct EventLinks: Codable {
    let linksSelf: SelfElement
    let attractions, venues: [SelfElement]

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case attractions, venues
    }
}

// MARK: - Sales
struct Sales: Codable {
    let salesPublic: Public

    enum CodingKeys: String, CodingKey {
        case salesPublic = "public"
    }
}

// MARK: - Public
struct Public: Codable {
    let startDateTime: Date
    let startTBD, startTBA: Bool
    let endDateTime: Date
}

// MARK: - Page
struct Page: Codable {
    let size, totalElements, totalPages, number: Int
}
