//
//  YourEventsView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct YourEventsView: View {
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Re-Live your Moments  ✨ ")
                    .fontWeight(.semibold)
                    .font(.system(size: 19))
                    .padding(.horizontal)
                EventList()
                    .padding(.horizontal)
                    .navigationTitle("Your Events")
                    .toolbar{
                        ToolbarItem(placement: .primaryAction) {
                            Button {
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
            }
        }
    }
}

struct YourEventsView_Previews: PreviewProvider {
    static var previews: some View {
        YourEventsView()
    }
}
