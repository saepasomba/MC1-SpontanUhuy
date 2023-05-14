//
//  HomepageView.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 02/05/23.
//

import SwiftUI

struct HomePageView: View {
    
    @EnvironmentObject var homePageViewModel: HomePageViewModel
    
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
                        
                        if homePageViewModel.isLoadingRecommendation {
                            ProgressView().progressViewStyle(.circular)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(homePageViewModel.recommendations, id: \.id) { recommendation in
                                        RoomCard(
                                            roomName: recommendation.name,
                                            imageURL: recommendation.imageURL,
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
                VStack(alignment: .center) {
                    Text("My Rooms")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: Constants.Color.primaryBlue))
                    
                    VStack {
                        if homePageViewModel.isLoadingRooms {
                            HStack {
                                Spacer()
                                ProgressView().progressViewStyle(.circular)
                                Spacer()
                            }
                        } else {
                            if homePageViewModel.message.isEmpty {
                                if homePageViewModel.searchResults.isEmpty {
                                    VStack(alignment: .center) {
                                        Image("image.empty")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                        
                                        Text("No Rooms yet!")
                                            .fontWeight(.semibold)
                                            .font(.title2)
                                            .foregroundColor(Color(hex: Constants.Color.primaryBlue))
                                            .padding(.top)
                                        
                                        Text("Once you add new room, you’ll see them here.")
                                            .foregroundColor(Color(hex: Constants.Color.primaryBlue))
                                            .padding(.top)
                                    }
                                    .padding(.top)
                                } else {
                                    RoomList(
                                        rooms: $homePageViewModel.searchResults
                                    )
                                }
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
            .refreshable {
                Task {
                    await homePageViewModel.initDataRooms()
                }
            }
            
            // MARK: Add new room button
            VStack {
                Spacer()
                NavigationLink {
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
            .padding(.bottom)
        }
        .task {
            await homePageViewModel.initDataRooms()
        }
        .task {
            await homePageViewModel.initDataRecommendations()
        }
        .onChange(of: homePageViewModel.searchField) { _ in
            homePageViewModel.searchData()
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
            
//            Button {
//                print("Favourite View")
//            } label: {
//                Image(systemName: "heart")
//                    .padding()
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 5)
//                            .stroke(lineWidth: 1)
//                            .fill(Color(hex: Constants.Color.primaryBlue))
//                    }
//            }
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
