//
//  AddUpcomingManuallyView.swift
//  Chimera
//
//  Created by Antonella Giugliano on 19/01/23.
//

import SwiftUI
import PhotosUI

struct AddUpcomingManuallyView: View {
    @State var performer = ""
    @State var date = ""
    @State var place = ""
    @State var image: PhotosPickerItem?
    var body: some View {
        Form{
            Section{
                PhotosPicker(selection: $image, matching: .images) {
                    ZStack{
                        if image == nil {
                            Image("event1")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 136)
                                .cornerRadius(24)
                                .padding(.horizontal)
                        }else{
//                                        Image(uiImage: UIImage(data: image))
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(height: 136)
//                                            .cornerRadius(24)
//                                            .padding(.horizontal)
                        }
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(height: 136)
                            .opacity(0.75)
                            .cornerRadius(24)
                            .padding(.horizontal)
                        
                        Text(image == nil ? "Select a Cover" : "Edit the Cover")
                            .foregroundColor(.accentColor)
                    }
                }
            }.listRowBackground(Color.clear)
                .padding(.top)
            
            Section {
                TextField("Name of Performer", text: $performer)
                TextField("Place of the Event", text: $place)
                TextField("Date of the Event", text: $date)
            }
        }
    }
}

struct AddUpcomingManuallyView_Previews: PreviewProvider {
    static var previews: some View {
        AddUpcomingManuallyView()
    }
}
