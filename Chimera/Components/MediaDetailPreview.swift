//
//  MediaDetailPreview.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 20/01/23.
//

import SwiftUI

struct MediaDetailPreview: View {
    @Binding var selectedItem: String
    let media: [MediaType]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(media) { item in
                    switch item {
                    case let .image(name):
                        Image(name)
                            .resizable()
                            .scaledToFill()
                            .frame(width: selectedItem == item.id ? 100 : 50, height: 50)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .animation(.easeInOut, value: selectedItem)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedItem == item.id ? .white : .clear, lineWidth: 4)
                            }
                            .onTapGesture {
                                selectedItem = item.id
                            }
                    case let .video(video):
                        Image(uiImage: video.thumbnail!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: selectedItem == item.id ? 100 : 50, height: 50)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedItem == item.id ? .white : .clear, lineWidth: 4)
                            }
                            .onTapGesture {
                                selectedItem = item.id
                            }
                    default:
                        EmptyView()
                    }
                }
            }
            .padding()
        }
    }
}

struct MediaDetailPreview_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetailPreview(selectedItem: .constant(""), media: [])
    }
}
