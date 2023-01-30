//
//  MediaDetailPreview.swift
//  Chimera
//
//  Created by Lorenzo Brescanzin on 20/01/23.
//

import SwiftUI

struct MediaDetailPreview: View {
    @Binding var selectedItem: UUID
    let media: [MediaMemo]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(media) { item in
                    if item.isVideo {
                        Image(uiImage: UIImage(cgImage: item.thumbnail!))
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
                    } else {
                        AsyncImage(url: item.url) { image in
                            image
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
                        } placeholder: {
                            EmptyView()
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct MediaDetailPreview_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetailPreview(selectedItem: .constant(UUID()), media: [])
    }
}
