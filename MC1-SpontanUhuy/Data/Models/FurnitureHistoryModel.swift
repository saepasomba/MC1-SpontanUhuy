//
//  FurnitureHistoryModel.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 05/05/23.
//

import Foundation
import CloudKit

class FurnitureHistoryModel: Identifiable {
    static let recordType = "FurnitureHistory"
    let id: CKRecord.ID
    let positionX: Double
    let positionY: Double
    let positionZ: Double
    var furniture: FurnitureModel? = nil
    
    init?(record: CKRecord) async {
        guard let positionX = record["position_x"] as? Double,
              let positionY = record["position_y"] as? Double,
              let positionZ = record["position_z"] as? Double,
              let reference = record["furniture"] as? CKRecord.Reference
        else { return nil }
        
        let db = CKContainer(identifier: "iCloud.id.spontan-uhuy.TemanRuang.TestContainer").privateCloudDatabase
        if let record = try? await db.record(for: reference.recordID) {
            if let furniture = FurnitureModel(record: record) {
                self.furniture = furniture
            }
        }
        
        self.id = record.recordID
        self.positionX = positionX
        self.positionY = positionY
        self.positionZ = positionZ
    }
}
