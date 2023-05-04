//
//  RoomView.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 01/05/23.
//

import SwiftUI
import RealityKit

struct RoomView: View {
    @EnvironmentObject var viewModel: RoomViewModel
    @State private var selectedFurniture = ""
    
    var body: some View {
        ZStack {
            RoomContainer()
            RoomSidebar(selectedFurniture: $selectedFurniture)
        }
    }
}

struct RoomSidebar: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RoomViewModel
    @State private var sidebarOpened = false
    @State private var selectedCategory = ""
    @State private var currentIndex = 0
    @Binding private var selectedFurniture: String
    
    init(selectedFurniture: Binding<String>) {
        self._selectedFurniture = selectedFurniture
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image("Icon Back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
                Spacer()
                if viewModel.furnitureSelected != nil {
                    Button {
                        viewModel.deleteFurniture()
                        selectedFurniture = ""
                    } label: {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .padding(.horizontal)
                    }
                }
                if !selectedFurniture.isEmpty {
                    Button {
                        viewModel.chosenModelToPlace = viewModel.furnitures.first
                    } label: {
                        Image("Image Checklist")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                    }
                }
                
                Spacer()
                
                Button {
                    print("Save")
                } label: {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
            }
            .padding()
            
            HStack {
                Spacer()
                VStack {
                    Button {
                        sidebarOpened = !sidebarOpened
                    } label: {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .rotationEffect(Angle(degrees: sidebarOpened ? 0 : 180))
                            .padding(8)
                            .padding(.vertical, 2)
                            .animation(.easeIn(duration: 0.4), value: sidebarOpened)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(hex: 0xFF3A6385))
                    
                    if sidebarOpened {
                        ScrollView {
                            ForEach(1..<4) { index in
                                VStack {
                                    Image("Category Chair")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    Text("Chair")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(hex: 0xFF3A6385))
                                }
                                .padding(8)
                                .padding(.horizontal, 12)
                                .background(Color(hex: selectedCategory == String(index) ? 0xFF71B4D0 : 0xFFFFFFFF, alpha: 0.65))
                                .cornerRadius(8)
                                .onTapGesture {
                                    if String(index) == selectedCategory {
                                        selectedCategory = ""
                                    } else {
                                        selectedCategory = String(index)
                                    }
                                    selectedFurniture = ""
                                }
                                .padding(.top, 4)
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                }
            }.animation(.easeIn, value: sidebarOpened)
                .padding(.horizontal, sidebarOpened ? 16 : -10)
                .padding(.vertical)
            
            Spacer()
            
            if !selectedCategory.isEmpty {
                HStack(alignment: .center) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                    
                    ScrollView(.horizontal) {
                        LazyHStack(alignment: .center) {
                            ForEach(1..<5) { index in
                                VStack(alignment: .center) {
                                    Image("Category Chair")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                    
                                    Text("Chair")
                                        .font(.caption)
                                }
                                .padding(10)
                                .padding(.horizontal, 10)
                                .background(Color(hex: selectedFurniture == String(index) ? 0xFF71B4D0 : 0xFFFFFFFF, alpha: 0.65))
                                .cornerRadius(8)
                                .onTapGesture {
                                    selectedFurniture = String(index)
                                }
                                .padding(.trailing, index == 4 ? 0 : 8)
                            }
                        }
                    }.scrollIndicators(.hidden)
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                .frame(height: 90)
                .padding()
                .background(Color(hex: 0xFF212121, alpha: 0.8))
                .cornerRadius(8)
                .animation(.easeIn(duration: 0.6), value: selectedCategory)
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .task {
            await viewModel.initData()
        }
    }
}

struct RoomSidebar_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
            .environmentObject(RoomViewModel())
    }
}

struct RoomSidebarIpad_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
            .environmentObject(RoomViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPad (10th generation)"))
    }
}
