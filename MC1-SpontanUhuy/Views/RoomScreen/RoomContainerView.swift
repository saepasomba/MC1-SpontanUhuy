//
//  RoomContainer.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 02/05/23.
//

import Foundation
import RealityKit
import SwiftUI

struct RoomContainerView: UIViewRepresentable {
    @EnvironmentObject var viewModel: RoomViewModel
    
    func makeUIView(context: Context) -> some UIView {
        let arView = CustomARView(frame: .zero) { handleClickedFurniture($0) }
        arView.addGestureRecognizer(UITapGestureRecognizer(target: arView, action: #selector(arView.handleClick(_:))))
        
        self.viewModel.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self) { (event) in
            if let chosenModelToPlace = self.viewModel.chosenModelToPlace {
                do {
                    let modelEntity = try getModel(fileName: chosenModelToPlace.name)
                    
                    let clonedModel = modelEntity.clone(recursive: true)
                    clonedModel.name = "\(chosenModelToPlace.name)_\(viewModel.furnitureAdded.count)"
                    clonedModel.generateCollisionShapes(recursive: true)
                    clonedModel.scale *= 0.1
                    
//                    let anchor = AnchorEntity(plane: .any)
                    let anchor = AnchorEntity()
                    
                    arView.installGestures(
                        [.translation, .scale, .rotation],
                        for: clonedModel
                    )
                    anchor.addChild(clonedModel)
                    arView.scene.addAnchor(anchor)
                    
                    viewModel.chooseFurniture(furniture: clonedModel)
                } catch {
                    print("Error is \(error)")
                }
            }
            
            if let modelToDelete = self.viewModel.modelToDelete {
                arView.scene.anchors.forEach {
                    if let entity = $0.findEntity(named: modelToDelete.model.name) {
                        $0.removeChild(entity)
                        arView.scene.removeAnchor($0)
                    }
                }
            }
            
            viewModel.chosenModelToPlace = nil
            viewModel.modelToDelete = nil
        }
        
        return arView
    }
    
    private func handleClickedFurniture(_ entity: Entity) {
        // Reset every model to default material
        viewModel.furnitureAdded.forEach { $0.model.setAllMaterials(materials: $0.defaultMaterials) }
        
        // Set selected model's material
        if let chosenFurniture = viewModel.furnitureAdded.first(where: { $0.model.id == entity.id }) {
            chosenFurniture.model.setAllMaterial(material: SimpleMaterial())
            viewModel.selectFurniture(furniture: chosenFurniture)
        }
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Do Nothing
    }
}

extension RoomContainerView {
    func getModel(fileName: String) throws -> ModelEntity {
        return try ModelEntity.loadModel(
            contentsOf: Bundle.main.url(forResource: fileName, withExtension: "usdz")!
        )
    }
}
