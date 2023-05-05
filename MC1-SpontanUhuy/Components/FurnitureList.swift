//
//  FurnitureList.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 05/05/23.
//

import Foundation
import SwiftUI

struct FurnitureList: View {
    let furnitures: [FurnitureModel]
    @Binding private var selectedFurniture: FurnitureModel?
    @Binding private var selectedCategory: CategoryModel?
    let onFurnitureClicked: () -> Void
    
    init(
        furnitures: [FurnitureModel],
        selectedFurniture: Binding<FurnitureModel?>,
        selectedCategory: Binding<CategoryModel?>,
        onFurnitureClicked: @escaping () -> Void
    ) {
        self.furnitures = furnitures
        self._selectedFurniture = selectedFurniture
        self._selectedCategory = selectedCategory
        self.onFurnitureClicked = onFurnitureClicked
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
            
            ScrollView(.horizontal) {
                LazyHStack(alignment: .center) {
                    ForEach(furnitures.indices, id: \.self) { index in
                        VStack(alignment: .center) {
                            FurnitureCard(imageURL: furnitures[index].imageURL)
                        }
                        .padding(12)
                        .background(
                            Color(
                                hex: selectedFurniture == furnitures[index] ? 0xFF71B4D0 : 0xFFFFFFFF,
                                alpha: 0.7
                            )
                        )
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedFurniture = furnitures[index]
                            onFurnitureClicked()
                        }
                        .padding(.trailing, furnitures[index] == selectedCategory?.furnitures.last ? 0 : 8)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            Image(systemName: "chevron.right").foregroundColor(.white)
        }
        .frame(height: 90)
        .padding()
        .background(Color(hex: 0xFF212121, alpha: 0.8))
        .cornerRadius(8)
        .animation(.easeIn(duration: 0.6), value: selectedCategory)
        .padding(.horizontal)
        .padding(.bottom)
    }
}
