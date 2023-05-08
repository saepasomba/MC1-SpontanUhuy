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
    let recommendation: RecommendationModel?
    
    var body: some View {
        
        // MARK: Room Idea Card
        NavigationLink {
            IdeasView(recommendation: recommendation)
                .navigationBarBackButtonHidden()
        } label: {
            ZStack {
                AsyncImage(
                    url: URL(string: imageURL)!,
                    content: { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 170, height: 100)
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
            recommendation: nil
        )
    }
}
