//
//  RoomList.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 05/05/23.
//

import Foundation
import SwiftUI

struct RoomList: View {
    @Binding var rooms: [RoomModel]
    
    var body: some View {
        ForEach(rooms) { room in
            NavigationLink {
                RoomFormView(
                    roomFormViewModel: RoomFormViewModel(
                        viewState: .editRoom,
                        room: room,
                        name: room.name,
                        imageURL: room.imageURL
                    )
                ).navigationBarBackButtonHidden()
            } label: {
                RoomListCard(
                    name: room.name,
                    imageURL: room.imageURL,
                    room: room
                )
            }
        }
    }
}

struct RoomListCard: View {
    let name: String
    let imageURL: String
    let room: RoomModel?
    
    var body: some View {
        HStack {
            // TODO: Show based on image availability
            AsyncImage(
                url: URL(string: imageURL)!,
                content: { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 80)
                        .cornerRadius(8)
                },
                placeholder: {
                    ZStack {
                        Color(.lightGray)
                        Text("No Image")
                            .foregroundColor(.gray)
                    }.frame(width: 120, height: 80)
                }
            )
            
            
            VStack(alignment: .leading, spacing: 10) {
                Text(name)
                    .fontWeight(.bold)
                
                Text("Last edited: 04/05/2023, 15:30")
                    .font(.caption)
            }
            .foregroundColor(Color(hex: Constants.Color.primaryBlue))
            .multilineTextAlignment(.leading)
            
            Spacer()
            
            VStack {
                NavigationLink {
                    RoomView(viewModel: RoomViewModel(room: room))
                        .navigationBarBackButtonHidden()
                } label: {
                    Image(systemName: "camera.viewfinder")
                        .foregroundColor(Color(hex: Constants.Color.primaryBlue))
                        .padding(5)
                        .overlay {
                            Circle()
                                .stroke(Color(hex: Constants.Color.primaryBlue), lineWidth: 1)
                        }
                }
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 123)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(hex: Constants.Color.primaryBlue), lineWidth: 1)
        }
        .cornerRadius(15)
    }
}

struct RoomListCard_Previews: PreviewProvider {
    static var previews: some View {
        RoomListCard(name: "Test", imageURL: "test", room: nil)
    }
}
