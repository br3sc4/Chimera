//
//  EventStore.swift
//  Chimera
//
//  Created by Simon Bestler on 25.01.23.
//

import Foundation

class EventStore : ObservableObject {
    @Published var eventStore = [Event]()
    
    private static func fileURL() -> URL {
        let baseDirectory = URL.documentsDirectory
        let fileName = baseDirectory.appendingPathComponent("events.json")
        return fileName
    }
    
    static func loadAllEvents(){
        let fileURL = fileURL()
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let eventStore = try JSONDecoder().decode([Event].self, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func save(events: [Event], completion: @escaping (Result<Int, Error>)->Void){
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(events)
                let outfile = fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(events.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    
}
