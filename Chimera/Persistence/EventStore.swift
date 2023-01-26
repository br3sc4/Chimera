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
    
    static func loadAllEvents(completion: @escaping (Result<[Event], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let events = try JSONDecoder().decode([Event].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(events))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
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
