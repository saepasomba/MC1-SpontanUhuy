//
//  RoomFormViewModel.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 03/05/23.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI

enum RoomFormViewState {
    case newRoom
    case editRoom
}

class RoomFormViewModel: ObservableObject {
    @Published var viewState: RoomFormViewState
    @Published var roomNameField: String
    @Published var selectedItem: PhotosPickerItem?
    @Published var selectedPhotoData: Data?
    
    init(viewState: RoomFormViewState, roomNameField: String = "", selectedItem: PhotosPickerItem? = nil, selectedPhotoData: Data? = nil) {
        self.viewState = viewState
        self.roomNameField = roomNameField
        self.selectedItem = selectedItem
        self.selectedPhotoData = selectedPhotoData
    }
}
