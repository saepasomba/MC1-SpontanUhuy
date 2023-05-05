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
        let query = CKQuery(recordType: FurnitureModel.recordType, predicate: predicate)
        let results = try await publicDB.records(matching: query)
        let records = results.matchResults.compactMap { try? $0.1.get() }
        return records.compactMap(FurnitureModel.init)
    }
    
    func getCategories() async throws -> [CategoryModel] {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: CategoryModel.recordType, predicate: predicate)
        let results = try await publicDB.records(matching: query)
        let records = results.matchResults.compactMap { try? $0.1.get() }
        
        var categories = [CategoryModel]()
        for record in records {
            if let category = await CategoryModel(record: record) {
                categories.append(category)
            }
        }
        
        return categories
    }
    
    func getRecommendations() async throws -> [RecommendationModel] {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecommendationModel.recordType, predicate: predicate)
        let results = try await publicDB.records(matching: query)
        let records = results.matchResults.compactMap { try? $0.1.get() }
        
        var recommendations = [RecommendationModel]()
        for record in records {
            if let recommendation = await RecommendationModel(record: record) {
                recommendations.append(recommendation)
            }
        }
        
        return recommendations
    }
    
    func getRooms() async throws -> [RoomModel] {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RoomModel.recordType, predicate: predicate)
        let results = try await privateDB.records(matching: query)
        let records = results.matchResults.compactMap { try? $0.1.get() }
        
        var rooms = [RoomModel]()
        for record in records {
            if let room = await RoomModel(record: record) {
                rooms.append(room)
            }
        }
        
        return rooms
    }
}
