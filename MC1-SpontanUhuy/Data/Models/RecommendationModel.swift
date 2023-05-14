//
//  RecommendationModel.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 05/05/23.
//

import Foundation
import CloudKit

class RecommendationModel: Identifiable {
    static let recordType = "Recommendations"
    let id: CKRecord.ID
    let name: String
    let imageURL: String
    let furnitures: [FurnitureModel]
    
    init?(record: CKRecord) async {
        guard let name = record["name"] as? String,
              let imageURL = record["imageURL"] as? String,
              let furnitureReferences = record["furnitures"] as? [CKRecord.Reference]
        else {
            return nil
        }
        
        var furnitures = [FurnitureModel]()
        let db = CKContainer(identifier: "iCloud.id.spontan-uhuy.TemanRuang.TestContainer").publicCloudDatabase
        for reference in furnitureReferences {
            if let record = try? await db.record(for: reference.recordID) {
                furnitures.append(FurnitureModel(record: record)!)
            }
        }
        
        self.id = record.recordID
        self.name = name
        self.imageURL = imageURL
        self.furnitures = furnitures
    }
}

extension RecommendationModel: Hashable {
    static func == (lf: RecommendationModel, rf: RecommendationModel) -> Bool {
        return lf.id == rf.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
