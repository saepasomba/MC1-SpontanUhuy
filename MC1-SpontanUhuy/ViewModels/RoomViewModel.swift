//
//  RoomViewModel.swift
//  MC1-SpontanUhuy
//
//  Created by Naufal Fawwaz Andriawan on 01/05/23.
//

import Foundation
import Combine

class RoomViewModel: ObservableObject {
    
    @Published var chosenModel: String? = nil
    
    var sceneObserver: Cancellable?
}
