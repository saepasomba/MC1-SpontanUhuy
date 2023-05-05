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
    @Published var message = ""
    @Published var isLoading = false
    
    private let repository = FurnitureRepository()
    
    func initData() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        do {
            let results = try await repository.getRecommendations()
            DispatchQueue.main.async {
                self.isLoading = false
                print("Result are \(results)")
                self.recommendations = results
            }
        } catch {
            DispatchQueue.main.async {
                self.message = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
