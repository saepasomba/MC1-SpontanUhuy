//
//  IdeasView.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 04/05/23.
//

import SwiftUI

struct IdeasView: View {
    let recommendation: RecommendationModel?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Text(recommendation?.name ?? "")
                    .fontWeight(.bold)
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                }
            }
            .padding()
            .font(.title3)
            
            VStack {
                ScrollView {
                    VStack {
                        ZStack {
                            AsyncImage(
                                url: URL(string: recommendation?.imageURL ?? ""),
                                content: { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 300)
                                        .cornerRadius(8)
                                        .clipped()
                                },
                                placeholder: {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .frame(height: 300)
                                }
                            )
//                            VStack {
//                                HStack {
//                                    Spacer()
//                                    Button {
//                                        print("Like idea")
//                                    } label: {
//                                        Image(systemName: "heart")
//                                            .padding(7)
//                                    }
//                                    .background {
//                                        Circle()
//                                            .fill(.white)
//                                            .overlay {
//                                                Circle()
//                                                    .stroke(Color(hex: Constants.Color.primaryBlue), lineWidth: 1)
//                                            }
//                                    }
//                                }
//                                Spacer()
//                            }
//                            .padding()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    VStack {
                        HStack {
                            Text("Product in this photo")
                            Spacer()
                            NavigationLink {
                                RoomView(
                                    viewModel: RoomViewModel(room: nil),
                                    furnitures: recommendation?.furnitures ?? []
                                )
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
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(recommendation?.furnitures ?? []) { furniture in
                                    AsyncImage(
                                        url: URL(string: furniture.imageURL)!,
                                        content: { image in
                                            image
                                                .resizable()
                                                .frame(width: 90, height: 60)
                                                .background {
                                                    Color(hex: Constants.Color.primaryCyan)
                                                        .opacity(0.3)
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(Color(hex: Constants.Color.primaryBlue), lineWidth: 1)
                                                        }
                                                }
                                                .cornerRadius(8)
                                        },
                                        placeholder: {
                                            ProgressView()
                                                .progressViewStyle(.circular)
                                                .frame(width: 90, height: 60)
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
            .padding(.bottom, 35)
        }
        .foregroundColor(Color(hex: Constants.Color.primaryBlue))
    }
}

//struct IdeasView_Previews: PreviewProvider {
//    static var previews: some View {
//        IdeasView()
//    }
//}
