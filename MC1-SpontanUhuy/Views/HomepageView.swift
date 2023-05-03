//
//  HomepageView.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 02/05/23.
//

import SwiftUI

struct HomepageView: View {
    
    @StateObject var homepageViewModel = HomepageViewModel()
    
    
    var body: some View {
        ZStack {
            ScrollView {
                
                //MARK: Top Bar
                //TODO: Samain height search field sama like button
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search room...", text: $homepageViewModel.searchField)
                    }
                    .padding()
                    .background {
                        Color(.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 2)
                                    .fill(Color(hex: Constants.Color.primaryBlue))
                            }
                    }
                    .cornerRadius(5)
                    Button {
                        print("Favourite View")
                    } label: {
                        Image(systemName: "heart")
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 1)
                                    .fill(Color(hex: Constants.Color.primaryBlue))
                            }
                    }
                    
                }
                .padding(.horizontal)
                
                //MARK: Room Ideas Section
                VStack(alignment: .leading) {
                    Text("Room Ideas")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: Constants.Color.primaryBlue))
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0...4, id: \.self) { index in
                                RoomCard(roomName: "Living Room", imageName: "DummyRoomPic")
                            }
                        }.padding(.horizontal)
                        
                    }
                }
                
                //MARK: My Rooms
                VStack {
                    Text("My Rooms")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: Constants.Color.primaryBlue))
                    VStack {
                        ForEach(0...5, id: \.self) { _ in
                            HStack {
                                Image("DummyRoomPic")
                                    .cornerRadius(15)
                                
                                Spacer()

                                VStack(alignment: .leading) {
                                    Text("Bedroom 1")
                                    Text("Last edited: Saturday, 15:30")
                                        .font(.caption)
                                }
                                .foregroundColor(Color(hex: Constants.Color.primaryBlue))

                                VStack {
                                    Button {
                                        print("Open AR View")
                                    } label: {
                                        Image(systemName: "camera.viewfinder")
                                            .foregroundColor(.white)
                                            .padding(5)
                                            .background {
                                                Circle()
                                                    .fill(Color(hex: Constants.Color.primaryBlue))
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
                    .padding(.horizontal)
                    .padding(.bottom, 75)
                }
                
            }
            
            //MARK: Add new room button
            VStack {
                Spacer()
                
                NavigationLink {
                    RoomView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Add New Room")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background {
                            Color(hex: Constants.Color.primaryBlue)
                            
                        }
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
