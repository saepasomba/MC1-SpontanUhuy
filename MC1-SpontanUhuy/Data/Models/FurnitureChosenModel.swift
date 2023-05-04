//
//  FurnitureChosenModel.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 03/05/23.
//

import Foundation
import RealityKit

struct FurnitureChosenModel: Identifiable {
    var id: UUID = UUID()
    let model: ModelEntity
    let defaultMaterials: [Material]
}
