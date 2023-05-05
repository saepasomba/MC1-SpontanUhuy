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
    @State private var selectedFurniture: FurnitureModel? = nil
    
    var body: some View {
        ZStack {
            RoomContainerView().ignoresSafeArea()
            RoomSidebar(selectedFurniture: $selectedFurniture)
        }
    }
}

struct RoomSidebar: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RoomViewModel
    
    @Binding private var selectedFurniture: FurnitureModel?
    
    @State private var sidebarOpened = false
    @State private var selectedCategory: CategoryModel? = nil
    
    init(selectedFurniture: Binding<FurnitureModel?>) {
        self._selectedFurniture = selectedFurniture
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.furnitureAdded.removeAll()
                    viewModel.modelToDelete = nil
                    viewModel.furnitureSelected = nil
                    dismiss()
                } label: {
                    Image("Icon Back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
                
                Spacer()
                
                Button {
                    print("Save")
                } label: {
                    Image("image.checklist")
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
                        Image("icon.furniture")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(8)
                            .padding(.vertical, 2)
                            .animation(.easeIn(duration: 0.4), value: sidebarOpened)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(hex: 0xFF3A6385))
                    
                    if sidebarOpened {
                        ScrollView {
                            ForEach(viewModel.categories) { category in
                                VStack {
                                    Image(category.imageURL)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    Text(category.name)
                                        .font(.caption2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(hex: 0xFF3A6385))
                                }
                                .padding(8)
                                .frame(width: 70)
                                .background(
                                    Color(
                                        hex: selectedCategory?.name == category.name ? 0xFF71B4D0 : 0xFFFFFFFF,
                                        alpha: 0.65
                                    )
                                )
                                .cornerRadius(8)
                                .onTapGesture {
                                    if category == selectedCategory {
                                        selectedCategory = nil
                                    } else {
                                        selectedCategory = category
                                    }
                                    selectedFurniture = nil
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
            
            HStack(spacing: 14) {
                if viewModel.furnitureSelected != nil {
                    Button {
                        viewModel.deleteFurniture()
                        selectedFurniture = nil
                    } label: {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .padding(.horizontal)
                    }
                }
                
                if selectedFurniture != nil {
                    Button {
                        viewModel.chosenModelToPlace = selectedFurniture
                    } label: {
                        Image("icon.place")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                    }
                }
            }.padding()
            
            if !(selectedCategory?.name ?? "").isEmpty {
                HStack(alignment: .center) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                    
                    ScrollView(.horizontal) {
                        LazyHStack(alignment: .center) {
                            ForEach((selectedCategory?.furnitures ?? [])) { furniture in
                                VStack(alignment: .center) {
//                                    AsyncImage(url: URL(string: furniture.imageURL)!)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 40, height: 40)
                                    Text(furniture.name)
                                }
                                .padding(12)
                                .background(
                                    Color(
                                        hex: selectedFurniture == furniture ? 0xFF71B4D0 : 0xFFFFFFFF,
                                        alpha: 0.7
                                    )
                                )
                                .cornerRadius(8)
                                .onTapGesture {
                                      selectedFurniture = furniture
                                }
                                .padding(.trailing, furniture == selectedCategory?.furnitures.last ? 0 : 8)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    Image(systemName: "chevron.right").foregroundColor(.white)
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
