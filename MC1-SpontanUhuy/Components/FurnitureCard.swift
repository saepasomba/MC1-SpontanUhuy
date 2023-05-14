//
//  FurnitureCard.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 05/05/23.
//

import Foundation
import SwiftUI

struct FurnitureCard: View {
    let imageURL: String
    
    var body: some View {
        AsyncImage(
            url: URL(string: imageURL)!,
            content: { image in
                image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            },
            placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }
        )
    }
}

struct FurnitureCard_Previews: PreviewProvider {
    static var previews: some View {
        FurnitureCard(imageURL: "https://picsum.photos/200/200")
    }
}
