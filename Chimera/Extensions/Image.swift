//
//  Image.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 13/01/23.
//

import SwiftUI

extension Image {
    func squared() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 0, maxHeight: .infinity)
            .clipped()
            .aspectRatio(1, contentMode: .fit)
    }
}
