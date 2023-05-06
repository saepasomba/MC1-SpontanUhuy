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
                if homePageViewModel.searchField.isEmpty && homePageViewModel.message.isEmpty {
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
                                            },
                                            recommendation: recommendation
                                        )
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top)
                }
                
                // MARK: My Rooms
                VStack(alignment: .leading) {
                    Text("My Rooms")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: Constants.Color.primaryBlue))
                    VStack {
                        if homePageViewModel.isLoading {
                            HStack {
                                Spacer()
                                ProgressView().progressViewStyle(.circular)
                                Spacer()
                            }
                        } else {
                            if homePageViewModel.message.isEmpty {
                                RoomList(rooms: $homePageViewModel.rooms)
                            } else {
                                Text("Error: \(homePageViewModel.message)")
                                    .padding(.top, 2)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 75)
                }
                .padding(.top)
            }
            
            // MARK: Add new room button
            VStack {
                Spacer()
                NavigationLink {
                    // RoomView().navigationBarBackButtonHidden()
                    RoomFormView(
                        roomFormViewModel: RoomFormViewModel(
                            viewState: .newRoom,
                            room: nil
                        )
                    ).navigationBarBackButtonHidden()
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
        .foregroundColor(Color(hex: Constants.Color.primaryBlue))
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
