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
    @Published var furnitureChosen: [FurnitureChosenModel] = []
    @Published var furnitureSelected: FurnitureChosenModel? = nil
    
    private var repository = FurnitureRepository()
    var sceneObserver: Cancellable?
    
    func initData() async {
        do {
            let furnitures = try await repository.fetchFurnitures()
            DispatchQueue.main.async {
                let furniture = try! ModelEntity.loadModel(contentsOf: Bundle.main.url(forResource: furnitures[0].fileName, withExtension: "usdz")!)
                self.furnitureChosen = [FurnitureChosenModel(model: furniture, defaultMaterials: furniture.model?.materials ?? [])]
                self.furnitures = furnitures
                print("Furnitures are \(furnitures)")
            }
        } catch {
            print("Error is \(error)")
        }
    }
    
    func selectModelToPlace(model: String) {
        
    }
    
    func selectFurniture(furniture: FurnitureChosenModel) {
        DispatchQueue.main.async {
            self.furnitureSelected = furniture
        }
    }
    
    func chooseFurniture(furniture model: ModelEntity) {
        furnitureChosen.append(FurnitureChosenModel(model: model, defaultMaterials: model.model?.materials ?? []))
    }
    
    func deleteFurniture() {
        modelToDelete = furnitureSelected
        furnitureChosen.remove(at: furnitureChosen.firstIndex(where: {$0.id == modelToDelete?.id}) ?? -1)
        furnitureSelected = nil
    }
    
    deinit {
        sceneObserver?.cancel()
    }
}
