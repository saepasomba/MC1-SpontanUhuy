//
//  RoomView.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 01/05/23.
//

import SwiftUI
import RealityKit

struct RoomView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: RoomViewModel
    var furnitures: [FurnitureModel]? = nil
    
    @State private var selectedFurniture: FurnitureModel? = nil
    
    var body: some View {
        ZStack {
            RoomContainerView().ignoresSafeArea()
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                RoomSidebar(
                    selectedFurniture: $selectedFurniture,
                    furnitures: furnitures
                )
            }
        }
        .environmentObject(viewModel)
        .onChange(of: viewModel.successUpdate) { newValue in
            if newValue {
                dismiss()
            }
        }
        .task {
            await viewModel.initData()
        }
    }
}

struct RoomSidebar: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RoomViewModel
    let furnitures: [FurnitureModel]?

    @Binding private var selectedFurniture: FurnitureModel?
    
    @State private var sidebarOpened = false
    @State private var dialogOpened = false
    @State private var selectedCategory: CategoryModel? = nil
    
    init(selectedFurniture: Binding<FurnitureModel?>, furnitures: [FurnitureModel]? = nil) {
        self._selectedFurniture = selectedFurniture
        self.furnitures = furnitures
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.furnitureAdded.removeAll()
                    viewModel.modelToDelete = nil
                    viewModel.furnitureSelected = nil
                    viewModel.chosenModelToPlace = nil
                    viewModel.initRoomPlaceFurnitures = nil
                    dismiss()
                } label: {
                    Image("Icon Back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
                
                Spacer()
                
                Button {
                    if viewModel.room == nil {
                        dismiss()
                    } else {
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            dialogOpened = true
                        } else {
                            selectedFurniture = nil
                            selectedCategory = nil
                            sidebarOpened = false
                            Task {
                                await viewModel.save()
                            }
                        }
                    }
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
                        if !viewModel.isLoading {
                            sidebarOpened = !sidebarOpened
                        }
                    } label: {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .frame(width: 24, height: 24)
                        } else {
                            Image("icon.furniture")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .padding(8)
                                .padding(.vertical, 2)
                                .animation(.easeIn(duration: 0.4), value: sidebarOpened)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(hex: 0xFF3A6385))
                    
                    if sidebarOpened {
                        ScrollView {
                            if furnitures != nil && (furnitures?.count ?? 0) > 0 {
                                VStack {
                                    Image(systemName: "star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color(hex: Constants.Color.primaryBlue))
                                }
                                .padding(8)
                                .frame(width: 70)
                                .background(
                                    Color(
                                        hex: selectedCategory == nil ? 0xFF71B4D0 : 0xFFFFFFFF,
                                        alpha: 0.65
                                    )
                                )
                                .cornerRadius(8)
                                .onTapGesture {
                                    selectedCategory = nil
                                    selectedFurniture = nil
                                }
                                .padding(.top, 4)
                            }
                            
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
                        Image("icon.clear.rounded")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .padding(.horizontal)
                    }
                    
                    Button {
                        viewModel.deselectFurniture()
                    } label: {
                        Image("icon.checklist.rounded")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .padding(.horizontal)
                    }
                }
                
                if let selected = selectedFurniture {
                    Button {
                        viewModel.selectModelToPlace(model: selected)
                        selectedFurniture = nil
                    } label: {
                        Image("icon.place")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                    }
                }
            }.padding()
            
            if !(selectedCategory?.name ?? "").isEmpty || !(furnitures ?? []).isEmpty {
                FurnitureList(
                    furnitures: selectedCategory != nil ? selectedCategory?.furnitures ?? [] : furnitures!,
                    selectedFurniture: $selectedFurniture,
                    selectedCategory: $selectedCategory,
                    onFurnitureClicked: {
                        viewModel.deselectFurniture()
                    }
                )
            }
        }
        .confirmationDialog("Are you sure?", isPresented: $dialogOpened) {
            Button("Yes") {
                selectedFurniture = nil
                selectedCategory = nil
                sidebarOpened = false
                Task {
                    await viewModel.save()
                }
            }
        } message: {
            Text("Are you sure you want to save your work?")
        }
    }
}


struct RoomSidebar_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(viewModel: RoomViewModel(room: nil))
    }
}

struct RoomSidebarIpad_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(viewModel: RoomViewModel(room: nil))
            .previewDevice(PreviewDevice(rawValue: "iPad (10th generation)"))
    }
}
