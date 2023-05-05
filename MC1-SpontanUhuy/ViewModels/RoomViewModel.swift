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
    
    @Published private(set) public var furnitures: [FurnitureModel] = []
    @Published private(set) public var categories: [CategoryModel] = []
    @Published var furnitureAdded: [FurnitureChosenModel] = []
    @Published var furnitureSelected: FurnitureChosenModel? = nil
    
    @Published var isLoading: Bool = false
    
    private let repository = FurnitureRepository()
    var sceneObserver: Cancellable?
    
    func initData() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        do {
            let categories = try await repository.getCategories()
            DispatchQueue.main.async {
                self.categories = categories
            }
            
            let furnitures = try await repository.fetchFurnitures()
            DispatchQueue.main.async {
                self.furnitureAdded = []
                self.furnitures = furnitures
                self.isLoading = false
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
        furnitureAdded.append(FurnitureChosenModel(model: model, defaultMaterials: model.model?.materials ?? []))
    }
    
    func deleteFurniture() {
        modelToDelete = furnitureSelected
        furnitureAdded.remove(at: furnitureAdded.firstIndex(where: {$0.id == modelToDelete?.id}) ?? -1)
        furnitureSelected = nil
    }
    
    deinit {
        sceneObserver?.cancel()
    }
}
