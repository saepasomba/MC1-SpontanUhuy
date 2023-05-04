//
//  ModelEntity+Material.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 04/05/23.
//

import Foundation
import RealityKit

extension ModelEntity {
    func setAllMaterial(material: Material) {
        self.model?.materials.indices.forEach {
            self.model?.materials[$0] = material
        }
    }
    
    func setAllMaterials(materials: [Material]) {
        self.model?.materials = materials
    }
}
