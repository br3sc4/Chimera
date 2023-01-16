//
//  MemoriesView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 16/01/23.
//

import SwiftUI

struct MemoriesView: View {
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("Re-Live your Moments  ✨ ")
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                ScrollView(showsIndicators: false){
                    EventList()
                        .padding(.horizontal)
                }
            }.navigationTitle("Memories")
                .navigationBarTitleDisplayMode(.large)
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

struct MemoriesView_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesView()
    }
}
