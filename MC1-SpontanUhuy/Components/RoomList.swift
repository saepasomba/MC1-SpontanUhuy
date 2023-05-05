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
                        roomNameField: room.name
                    )
                ).navigationBarBackButtonHidden()
            } label: {
                RoomListCard(
                    name: "Test", imageURL: "Test"
                )
            }
        }
    }
}

struct RoomListCard: View {
    let name: String
    let imageURL: String
    
    var body: some View {
        HStack {
            Group {
                // TODO: Show based on image availability
//                if index % 2 == 0 {
//                    Image("DummyRoomPic")
//                        .cornerRadius(15)
//                } else {
//                    ZStack {
//                        Color(.lightGray)
//                        Text("No Image")
//                            .foregroundColor(.gray)
//                    }
//                }
            }
            .frame(width: 150, height: 100)
            .cornerRadius(15)
            
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Bedroom 1")
                    .fontWeight(.bold)
                
                Text("Last edited: 04/05/2023, 15:30")
                    .font(.caption)
            }
            .foregroundColor(Color(hex: Constants.Color.primaryBlue))
            .multilineTextAlignment(.leading)
            
            Spacer()
            
            VStack {
                Button {
                    print("Open AR View")
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
        RoomListCard(name: "Test", imageURL: "test")
    }
}
