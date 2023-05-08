//
//  RoomModel.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 05/05/23.
//

import Foundation
import CloudKit

class RoomModel: Identifiable {
    static let recordType = "Rooms"
    let id: CKRecord.ID
    let name: String
    let imageURL: String
    let furnitures: [FurnitureHistoryModel]
    
    init?(record: CKRecord) async {
        guard let name = record["name"] as? String,
              let imageURL = record["imageURL"] as? String
        else { return nil }
        
        let historyReference = (record["furnitures"] as? [CKRecord.Reference]) ?? []
        
        var furnitures = [FurnitureHistoryModel]()
        let db = CKContainer(identifier: "iCloud.id.spontan-uhuy.TemanRuang.TestContainer").privateCloudDatabase
        for reference in historyReference {
            if let record = try? await db.record(for: reference.recordID) {
                if let furniture = await FurnitureHistoryModel(record: record) {
                    furnitures.append(furniture)
                }
            }
        }
        
        self.id = record.recordID
        self.name = name
        self.imageURL = imageURL
        self.furnitures = furnitures
    }
}
