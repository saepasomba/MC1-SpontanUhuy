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
        NavigationLink {
            IdeasView()
                .navigationBarBackButtonHidden()
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
