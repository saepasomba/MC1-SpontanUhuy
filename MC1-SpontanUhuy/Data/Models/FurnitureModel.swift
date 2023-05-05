//
//  FurnitureModel.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 02/05/23.
//

import Foundation
import CloudKit
import RealityKit

class FurnitureModel: Identifiable {
    static let recordType = "Furniture"
    let id: CKRecord.ID
    let name: String
    let price: Int64
    let fileName: String
    var model: ModelEntity? = nil
    
    init?(record: CKRecord) {
        guard let name = record["name"] as? String,
              let price = record["price"] as? Int64,
              let fileName = record["name"] as? String
        else { return nil }
        
        id = record.recordID
        self.name = name
        self.price = price
        self.fileName = fileName
    }
}

extension FurnitureModel: Hashable {
    static func == (lf: FurnitureModel, rf: FurnitureModel) -> Bool {
        return lf.id == rf.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
