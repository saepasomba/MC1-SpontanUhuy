//
//  RoomCard.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 02/05/23.
//

import SwiftUI

struct RoomCard: View {
    
    var roomName: String
    var imageName: String
    
    var body: some View {
        //MARK: Room Idea Card
        Button {
            print("Open Room Ideas View")
        } label: {
            ZStack {
                Image(imageName)
                    .overlay(content: {
                        Color(hex: 0xFF424242, alpha: 0.3)
                    })
                    .cornerRadius(15)
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
        
    }
}

struct RoomCard_Previews: PreviewProvider {
    static var previews: some View {
        RoomCard(roomName: "Living Room", imageName: "DummyRoomPic")
    }
}
