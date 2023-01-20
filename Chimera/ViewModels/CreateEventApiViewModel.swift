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
    @Published var eventName : String
    @Published var cityName : String
    
    @Published var events  : [Event]
    
    var urlComponents : URLComponents
    
    init() {
        self.ticketMasterResults = nil
        self.eventName = ""
        self.cityName = "Napoli"
        self.urlComponents = URLComponents(string: "https://app.ticketmaster.com/")!
        self.events = []
    }
    
    
    func getEvents() async {
        
        urlComponents.path = "/discovery/v2/events"
        
        //TODO: Check if/how you can specify API-Code outsitde of source
        let apiKeyQery = URLQueryItem(name: "apikey", value: "DxmW4FBMq7gyPeRrRPdI7fCocVAxrO56")
        let localeQuery = URLQueryItem(name: "locale", value: "IT")
        let cityQuery = URLQueryItem(name: "city", value: cityName)
        let keyWordQuery = URLQueryItem(name: "keyword", value: eventName)
        
        urlComponents.queryItems = [apiKeyQery,
                                    localeQuery,
                                    cityQuery,
                                    keyWordQuery]
        
        let url = urlComponents.url!
        
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    
                    print(String(data: data, encoding: .utf8)!)
                    //print(response)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    
                    let decoder = JSONDecoder()
                    
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    ticketMasterResults = try decoder.decode(TicketMasterAPI.self, from: data)
                    
                    for tMevent in ticketMasterResults!.embedded.events {
                        let event = Event(performer: tMevent.embedded.attractions.first?.name ?? "Not provided", place: tMevent.embedded.venues.first?.city.name ?? "Not provided", date: tMevent.dates.start.localDate, image: "event1")
                        events.append(event)
                    }
                    
                }
                    catch {
                        print("Error!!")
                        print(error.localizedDescription)
                    }
    }
}
