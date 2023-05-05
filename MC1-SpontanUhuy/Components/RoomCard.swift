//
//  RoomCard.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 02/05/23.
//

import SwiftUI

struct RoomCard: View {
    
    let roomName: String
    let imageURL: String
    let onCardClicked: () -> Void
    
    var body: some View {
        Button {
            onCardClicked()
        } label: {
            ZStack {
                AsyncImage(
                    url: URL(string: imageURL)!,
                    content: { image in
                        image
                            .overlay {
                                Color(hex: 0xFF424242, alpha: 0.3)
                            }
                    },
                    placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                )
                
                Text(roomName)
                    .bold()
                    .foregroundColor(.white)
                
//                VStack(alignment: .leading) {
//                    Text(roomName)
//                        .bold()
//                        .foregroundColor(.white)
//                    Spacer()
//                    Image(systemName: "arrow.forward")
//                        .foregroundColor(.cyan)
//                        .scaleEffect(0.6)
//                        .padding(3)
//                        .background {
//                            Circle()
//                                .fill(.white)
//                                .overlay {
//                                    Circle().stroke(.cyan, style: StrokeStyle(lineWidth: 1))
//                                }
//                        }
//
//
//                }
//                .padding(.vertical)
            }
            .frame(height: 100)
        }
        .cornerRadius(8)
    }
}

struct RoomCard_Previews: PreviewProvider {
    static var previews: some View {
        RoomCard(
            roomName: "Living Room",
            imageURL: "https://picsum.photos/id/237/200/300",
            onCardClicked: {
                
            }
        )
    }
}
