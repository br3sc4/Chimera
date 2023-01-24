//
//  MemorySearchToken.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 17/01/23.
//

import Foundation

enum MemorySearchToken: Identifiable, Hashable {
    case performer(name: String), place(city: String)
    
    var id: Self {
        self
    }
}
