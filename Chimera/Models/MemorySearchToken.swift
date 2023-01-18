//
//  MemorySearchToken.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 17/01/23.
//

import Foundation

enum MemorySearchToken: String, Identifiable, Hashable, CaseIterable {
    case coldplay, guns
    
    var id: Self {
        self
    }
}
