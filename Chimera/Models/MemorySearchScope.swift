//
//  MemorySearchScope.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 17/01/23.
//

import Foundation

enum MemorySearchScope: String, CaseIterable, Identifiable {
    case artist, place
    
    var id: Self {
        self
    }
}
