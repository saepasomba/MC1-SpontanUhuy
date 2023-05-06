//
//  RoomViewModel.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 01/05/23.
//

import Foundation
import Combine
import RealityKit

class RoomViewModel: ObservableObject {
    
    // For one time event purpose
    @Published var chosenModelToPlace: FurnitureModel? = nil
    @Published var modelToDelete: FurnitureChosenModel? = nil
    @Published var initRoomPlaceFurnitures: [FurnitureHistoryModel]? = nil
    
    @Published private(set) public var categories: [CategoryModel] = []
    @Published var furnitureAdded: [FurnitureChosenModel] = []
    @Published var furnitureSelected: FurnitureChosenModel? = nil
    
    @Published var isLoading: Bool = false
    @Published var successUpdate: Bool = false
    
    private let repository = FurnitureRepository()
    let room: RoomModel?
    var sceneObserver: Cancellable?
    
    init(room: RoomModel?) {
        self.room = room
        if let room = room, !room.furnitures.isEmpty {
            var furnitureModels: [FurnitureHistoryModel] = []
            room.furnitures.forEach { furniture in
                furnitureModels.append(furniture)
            }
            initRoomPlaceFurnitures = furnitureModels
        }
    }
    
    func initData() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        do {
            let categories = try await repository.getCategories()
            DispatchQueue.main.async {
                self.categories = categories
                self.isLoading = true
            }
        } catch {
            print("Error is \(error)")
        }
    }
    
    func selectModelToPlace(model: FurnitureModel) {
        chosenModelToPlace = model
    }
    
    func selectFurniture(furniture: FurnitureChosenModel) {
        DispatchQueue.main.async {
            self.furnitureSelected = furniture
        }
    }
    
    func deselectFurniture() {
        if let selected = furnitureSelected {
            selected.model.setAllMaterials(materials: selected.defaultMaterials)
            furnitureSelected = nil
        }
    }
    
    func chooseFurniture(furniture model: ModelEntity) {
        furnitureAdded.append(
            FurnitureChosenModel(
                model: model,
                furniture: chosenModelToPlace,
                defaultMaterials: model.model?.materials ?? []
            )
        )
    }
    
    func deleteFurniture() {
        modelToDelete = furnitureSelected
        furnitureAdded.remove(at: furnitureAdded.firstIndex(where: {$0.id == modelToDelete?.id}) ?? -1)
        furnitureSelected = nil
    }
    
    func save() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        if let room = room {
            await repository.updateRoom(
                id: room.id,
                name: room.name,
                imageData: nil,
                furnitures: furnitureAdded
            ) { results in
                switch results {
                case .success(_):
                    print("Success")
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.successUpdate = true
                    }
                case .failure(_):
                    print("Error")
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.successUpdate = false
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.isLoading = true
                self.successUpdate = false
            }
        }
    }
    
    deinit {
        sceneObserver?.cancel()
    }
}
