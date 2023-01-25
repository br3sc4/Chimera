//
//  UpcomingView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 16/01/23.
//

import SwiftUI

struct UpcomingView: View {
    @State var isShowingAddUpcoming = false

    var body: some View {
        NavigationStack {
            EventList(eventType: .upcoming)
                .navigationTitle("Upcoming Events")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            isShowingAddUpcoming.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
        .sheet(isPresented: $isShowingAddUpcoming) {
            AddUpcomingView()
        }
    }
}


struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView().environmentObject(EventVM())
    }
}
