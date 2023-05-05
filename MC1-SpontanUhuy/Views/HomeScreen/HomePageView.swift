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
                // MARK: Top Bar
                // TODO: Samain height search field sama like button
                HomeTopBar()
                    .padding(.top)
                    .environmentObject(homePageViewModel)
                
                // MARK: Room Ideas Section
                if homePageViewModel.searchField.isEmpty {
                    VStack {
                        Text("Room Ideas")
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: Constants.Color.primaryBlue))
                        
                        if homePageViewModel.isLoading {
                            ProgressView().progressViewStyle(.circular)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(homePageViewModel.recommendations, id: \.id) { recommendation in
                                        RoomCard(
                                            roomName: recommendation.name,
                                            imageURL: recommendation.imageURL,
                                            onCardClicked: {
                                                print("Card Clicked")
                                            }
                                        )
                                    }
                                }.padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top)
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
                        ForEach(0...5, id: \.self) { index in
                            NavigationLink {
                                RoomFormView(roomFormViewModel: RoomFormViewModel(viewState: .editRoom, roomNameField: "Bedroom 1"))
                                    .navigationBarBackButtonHidden()
                            } label: {
                                HStack {
                                    Group {
                                        // TODO: Show based on image availability
                                        if index % 2 == 0 {
                                            Image("DummyRoomPic")
                                                .cornerRadius(15)
                                        } else {
                                            ZStack {
                                                Color(.lightGray)
                                                Text("No Image")
                                                    .foregroundColor(.gray)
                                            }
                                        }
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
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 75)
                }
                .padding(.top)
            }
            
            //MARK: Add new room button
            VStack {
                Spacer()
                NavigationLink {
                    RoomView().navigationBarBackButtonHidden()
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
        .task {
            await homePageViewModel.initData()
        }
    }
}

struct HomeTopBar: View {
    @EnvironmentObject var homePageViewModel: HomePageViewModel
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search room...", text: $homePageViewModel.searchField)
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
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

struct HomeTopBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeTopBar()
            .environmentObject(HomePageViewModel())
    }
}
