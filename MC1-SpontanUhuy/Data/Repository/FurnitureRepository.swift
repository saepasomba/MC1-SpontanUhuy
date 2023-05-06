//
//  Model.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 02/05/23.
//

import Foundation
import CloudKit
import Cloudinary

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
    
    func saveFurnitureHistory(furniture: FurnitureChosenModel) async throws -> FurnitureHistoryModel? {
        if let furnitureModel = furniture.furniture {
            let newRecord = CKRecord(recordType: FurnitureHistoryModel.recordType)
            newRecord.setValuesForKeys([
                "position_x": await Double(furniture.model.position.x),
                "position_y": await Double(furniture.model.position.y),
                "position_z": await Double(furniture.model.position.z),
                "furniture": CKRecord.Reference(recordID: furnitureModel.id, action: .deleteSelf)
            ])
            let record = try await privateDB.save(newRecord)
            return await FurnitureHistoryModel(record: record)
        } else {
            return nil
        }
    }
    
    func updateRoom(
        id: CKRecord.ID,
        name: String,
        imageData: Data?,
        furnitures: [FurnitureChosenModel] = [],
        completion: @escaping (Result<Bool, Error>
    ) -> Void) async {
        
        do {
            let record = try await privateDB.record(for: id)
            
            if let data = imageData {
                let config = CLDConfiguration(cloudName: "dggxoopi8", apiKey: "898787985328797")
                let cloudinary = CLDCloudinary(configuration: config)
                
                let request = cloudinary.createUploader().upload(data: data, uploadPreset: "ebd8r09c") { progress in
                    print("UPLOAD IMAGE... \(progress.completedUnitCount) : \(progress.totalUnitCount)")
                } completionHandler: { result, error in
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        let url = result?.url ?? ""
                        
                        record.setValuesForKeys([
                            "name": name,
                            "description": name,
                            "imageURL": url.replacing("http", with: "https")
                        ])
                        
                        self.privateDB.save(record) { _, error in
                            if let error = error {
                                completion(Result.failure(error))
                            } else {
                                completion(Result.success(true))
                            }
                        }
                    }
                }
                
                request.resume()
            } else {
                do {
                    if !furnitures.isEmpty {
                        var histories: [FurnitureHistoryModel] = []
                        for furniture in furnitures {
                            if let furnitureHistory = try? await saveFurnitureHistory(furniture: furniture) {
                                histories.append(furnitureHistory)
                            }
                        }
                        record.setValue(histories.map { CKRecord.Reference(recordID: $0.id, action: .deleteSelf) }, forKey: "furnitures")
                    }
                    
                    record.setValuesForKeys([
                        "name": name,
                        "description": name
                    ])
                    
                    let results = try await self.privateDB.modifyRecords(saving: [record], deleting: [])
                    completion(Result.success(true))
                } catch {
                    completion(Result.failure(error))
                }
            }
        } catch {
            completion(Result.failure(error))
        }
    }
    
    func insertRoom(name: String, imageData: Data, completion: @escaping (Result<Bool, Error>) -> Void) async {
        let record = CKRecord(recordType: RoomModel.recordType)
        let config = CLDConfiguration(cloudName: "dggxoopi8", apiKey: "898787985328797")
        let cloudinary = CLDCloudinary(configuration: config)
        
        let request = cloudinary.createUploader().upload(data: imageData, uploadPreset: "ebd8r09c") { progress in
            print("UPLOAD IMAGE... \(progress.completedUnitCount) : \(progress.totalUnitCount)")
        } completionHandler: { result, error in
            if let error = error {
                completion(Result.failure(error))
            } else {
                let url = result?.url ?? ""
                
                record.setValuesForKeys([
                    "name": name,
                    "description": name,
                    "imageURL": url.replacing("http", with: "https")
                ])
                
                self.privateDB.save(record) { record, error in
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.success(true))
                    }
                }
            }
        }
        
        request.resume()
    }
    
    func deleteRoom(id: CKRecord.ID?) async throws -> Bool {
            do {
                if let id = id {
                    let _ = try await privateDB.deleteRecord(withID: id)
                    return true
                } else {
                    return false
                }
            } catch {
                return false
            }
        }
}
