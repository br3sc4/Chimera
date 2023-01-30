//
//  AddMemoryUpcomingEventsView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 24/01/23.
//

import SwiftUI

struct AddMemoryUpcomingEventsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                    }, label: {
                        Text("Done")
                    })
                }
            }
    }
}

struct AddMemoryUpcomingEventsView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoryUpcomingEventsView()
    }
}
