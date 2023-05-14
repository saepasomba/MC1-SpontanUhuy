//
//  HomepageViewModel.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 02/05/23.
//

import Foundation
import SwiftUI

class HomePageViewModel: ObservableObject {
    @Published var searchField: String = ""
    @Published var recommendations: [RecommendationModel] = []
    @Published var rooms: [RoomModel] = []
    @Published var message = ""
    @Published var isLoadingRecommendation = false
    @Published var isLoadingRooms = false
    @Published var searchResults: [RoomModel] = []
    
    private let repository = FurnitureRepository()
    
    func initDataRecommendations() async {
        DispatchQueue.main.async {
            self.isLoadingRecommendation = true
        }
        
        do {
            let results = try await repository.getRecommendations()
            DispatchQueue.main.async {
                self.isLoadingRecommendation = false
                self.recommendations = results
            }
        } catch {
            DispatchQueue.main.async {
                self.message = error.localizedDescription
                self.isLoadingRecommendation = false
            }
        }
    }
    
    func initDataRooms() async {
        DispatchQueue.main.async {
            self.isLoadingRooms = true
        }
        
        do {
            let results = try await repository.getRooms()
            DispatchQueue.main.async {
                print("New rooms: \(results.map { $0.name })")
                self.isLoadingRooms = false
                self.rooms = results
                self.searchResults = results
            }
        } catch {
            DispatchQueue.main.async {
                self.message = error.localizedDescription
                self.isLoadingRooms = false
            }
        }
    }
    
    func searchData() {
        if searchField.isEmpty {
            DispatchQueue.main.async {
                self.searchResults = self.rooms
            }
            return
        }
        
        DispatchQueue.main.async {
            self.searchResults = self.rooms.filter({ room in
                return room.name.lowercased().contains(self.searchField.lowercased())
            })
        }
    }
}
