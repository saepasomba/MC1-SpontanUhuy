//
//  Model.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 02/05/23.
//

import Foundation
import CloudKit

class FurnitureRepository {
    let container: CKContainer
    let publicDB: CKDatabase
    let privateDB: CKDatabase
    
    init() {
        container = CKContainer(identifier: "iCloud.id.spontan-uhuy.TemanRuang.TestContainer")
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    func fetchFurnitures() async throws -> [FurnitureModel] {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Furniture", predicate: predicate)
        let results = try await publicDB.records(matching: query)
        let records = results.matchResults.compactMap { try? $0.1.get() }
        return records.compactMap(FurnitureModel.init)
    }
}
