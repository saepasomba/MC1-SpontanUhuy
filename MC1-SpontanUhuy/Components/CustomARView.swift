//
//  CustomARView.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 01/05/23.
//

import RealityKit
import ARKit
import Combine
import SwiftUI
import FocusEntity

class CustomARView: ARView {
    
    var focusEntity: FocusEntity?
    var onEntityClicked: ((Entity) -> Void)?
    
    required init(frame frameRect: CGRect, onEntityClicked: @escaping (Entity) -> Void) {
        super.init(frame: frameRect)
        self.onEntityClicked = onEntityClicked
        focusEntity = FocusEntity(on: self, style: .classic(color: .blue))
        configure()
    }
    
    @MainActor @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    @MainActor @objc required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    private func configure() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.vertical, .horizontal]
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        session.run(config)
    }
    
    @objc func handleClick(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        if let entity = self.entity(at: location) {
            print("\(entity.name) Clicked")
            self.onEntityClicked?(entity)
        }
    }
}
