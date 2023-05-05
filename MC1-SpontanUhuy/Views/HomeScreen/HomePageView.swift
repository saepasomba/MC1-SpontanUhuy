//
//  HomepageView.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 02/05/23.
//

import SwiftUI

struct HomePageView: View {
    @StateObject var homePageViewModel = HomePageViewModel()
    
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
