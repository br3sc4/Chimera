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
    @Published var searchQuery : String
    @Published var locale : String
    @Published var date : Date
    @Published var events  : [Event]
    
    var urlComponents : URLComponents
    
    init() {
        self.ticketMasterResults = nil
        self.searchQuery = ""
        self.locale = "IT"
        self.urlComponents = URLComponents(string: "https://app.ticketmaster.com/")!
        self.events = []
        self.date = Date()
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
        let startDateQuery = URLQueryItem(name: "startDateTime", value: startTimeFormatted)
        let endDatQuery = URLQueryItem(name: "endDateTime", value: endTimeFormatted)
        
        urlComponents.queryItems = [apiKeyQery,
                                    localeQuery,
                                    startDateQuery,
                                    endDatQuery,
                                    keyWordQuery]
        
        let url = urlComponents.url!
        print(url)
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    print(String(data: data, encoding: .utf8)!)
                    //print(response)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    ticketMasterResults = try decoder.decode(TicketMasterAPI.self, from: data)
                    events = []
                    var imageURL = "event1"
                    for tMevent in ticketMasterResults!.embedded.events {
                        if tMevent.images.count > 5 {
                            imageURL = tMevent.images[5].url
                        } else if tMevent.images.count > 0 {
                            imageURL = tMevent.images[0].url
                        }
                        
                        let event = Event(performer: tMevent.embedded.attractions?.first?.name ?? "Not provided",
                                          place: tMevent.embedded.venues.first?.city.name ?? "Not provided",
                                          date: tMevent.dates.start.localDate,
                                          image: imageURL)
                        events.append(event)
                    }
                } catch {
                        print("Error!!")
                        print(error.localizedDescription)
                }
    }
}
