//
//  CreateEventApiViewModel.swift
//  Chimera
//
//  Created by Simon Bestler on 18.01.23.
//

import Foundation

@MainActor
class CreateEventApiViewModel : ObservableObject {
    private var ticketMasterResults : TicketMasterAPI?
    @Published var isUseDate : Bool
    @Published var searchQuery : String
    @Published var locale : String
    @Published var date : Date
    @Published var events  : [Event]
    @Published var isError : Bool
    
    var urlComponents : URLComponents
    
    init() {
        self.ticketMasterResults = nil
        self.isUseDate = false
        self.searchQuery = ""
        self.locale = "IT"
        self.urlComponents = URLComponents(string: "https://app.ticketmaster.com/")!
        self.events = []
        self.date = Date()
        self.isError = false
    }
    
    
    func getEvents() async {
        
        urlComponents.path = "/discovery/v2/events"
        
        
        let calendar = Calendar.current
        let startTime = calendar.startOfDay(for: date)
        let endTime = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: date)!
        

        
        let startTimeFormatted = startTime.formatted(.iso8601)
        let endTimeFormatted = endTime.formatted(.iso8601)
        
        //TODO: Check if/how you can specify API-Code outsitde of source
        let apiKeyQery = URLQueryItem(name: "apikey", value: "DxmW4FBMq7gyPeRrRPdI7fCocVAxrO56")
        let localeQuery = URLQueryItem(name: "locale", value: locale)
        let keyWordQuery = URLQueryItem(name: "keyword", value: searchQuery)
        let classificationID = URLQueryItem(name: "classificationID", value: "KZFzniwnSyZfZ7v7nJ")
        
        if isUseDate {
            let startDateQuery = URLQueryItem(name: "startDateTime", value: startTimeFormatted)
            let endDatQuery = URLQueryItem(name: "endDateTime", value: endTimeFormatted)
            
            urlComponents.queryItems = [apiKeyQery,
                                        localeQuery,
                                        classificationID,
                                        startDateQuery,
                                        endDatQuery,
                                        keyWordQuery]
        } else {
            urlComponents.queryItems = [apiKeyQery,
                                        localeQuery,
                                        classificationID,
                                        keyWordQuery]
        }
        let url = urlComponents.url!
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    ticketMasterResults = try decoder.decode(TicketMasterAPI.self, from: data)
                    events = []
                    var imageURL = ""
                    for tMevent in ticketMasterResults!.embedded.events {
                        
                        imageURL = getImageURL(for: tMevent)
                        
                        let event = Event(performer: tMevent.embedded.attractions?.first?.name ?? "Not provided",
                                          place: tMevent.embedded.venues?.first?.city?.name ?? "Not provided",
                                          date: tMevent.dates.start?.dateTime ?? Date(),
                                          image: imageURL, isMemory: false)
                        events.append(event)
                    }
                } catch {
                    print(error)
                    isError = true
                }
    }
    
    private func getImageURL(for event : TMEvent) -> String {
        var imageURL = "event1"
        if event.images.count > 5 {
            imageURL = event.images[5].url
        } else if event.images.count > 0 {
            imageURL = event.images[0].url
        }
        return imageURL
    }
    
    private func downloadPreviewImage(from stringUrl : String) async -> URL{
        let url = URL(string: stringUrl)
        let documentDirectoryPath = URL.documentsDirectory
        let filePath = documentDirectoryPath.appendingPathComponent("\(UUID()).jpg")
        
        do {
            if let url {
                let (data, _) = try await URLSession.shared.data(from: url)
                try data.write(to: filePath)
                
            }
        } catch {
            print(error)
        }
        print(filePath)
        return filePath//.absoluteString
        
    }
    
    /* Downloads an image for the preview to make it available for offline usage */
    func eventWithPreview(_ event : Event) async -> Event{
        var newEvent = event
        let imageURL = await downloadPreviewImage(from: event.image ?? "")
        newEvent.cover = imageURL
        return newEvent
    }
    
    //TODO: Refactor with Data directly from Store not from vm
    func checkIfEventAlreadyExists(events: [Event], searchEvent: Event) -> Bool{
        return events.contains(where: {
            $0.date == searchEvent.date &&
            $0.performer == searchEvent.performer &&
            $0.place == searchEvent.place
        })
    }
}


