//
//  IdeasView.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 04/05/23.
//

import SwiftUI

struct IdeasView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Text("Bedroom")
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
            .padding(.horizontal)
            .padding(.bottom)
            .font(.title3)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(0...4, id: \.self) { _ in
                    VStack {
                        VStack {
                            ZStack {
                                Image("DummyRoomPic")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 143)
                                    .cornerRadius(8)
                                    .clipped()
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        Button {
                                            print("Like idea")
                                        } label: {
                                            Image(systemName: "heart")
                                                .padding(7)
                                        }
                                        .background {
                                            Circle()
                                                .fill(.white)
                                                .overlay {
                                                    Circle()
                                                        .stroke(Color(hex: Constants.Color.primaryBlue), lineWidth: 1)
                                                }
                                        }
                                    }
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                        .padding(.horizontal)
                        
                        VStack {
                            HStack {
                                Text("Product in this photo")
                                Spacer()
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
                            }
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(1...5, id: \.self) { _ in
                                        Image(systemName: "table.furniture")
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
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.bottom, 35)
                }
            }
        }
        .foregroundColor(Color(hex: Constants.Color.primaryBlue))
    }
}

struct IdeasView_Previews: PreviewProvider {
    static var previews: some View {
        IdeasView()
    }
}
