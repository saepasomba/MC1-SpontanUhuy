//
//  RoomFormViewModel.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 03/05/23.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI
import Cloudinary

enum RoomFormViewState {
    case newRoom
    case editRoom
}

class RoomFormViewModel: ObservableObject {
    @Published var viewState: RoomFormViewState
    @Published var roomNameField: String
    @Published var selectedItem: PhotosPickerItem?
    @Published var selectedPhotoData: Data?
    @Published var isUploading: Bool?
    @Published var imageUrl: URL?
    
    var config: CLDConfiguration
    var cloudinary: CLDCloudinary
    
    init(viewState: RoomFormViewState, roomNameField: String = "", selectedItem: PhotosPickerItem? = nil, selectedPhotoData: Data? = nil) {
        self.viewState = viewState
        self.roomNameField = roomNameField
        self.selectedItem = selectedItem
        self.selectedPhotoData = selectedPhotoData
        
        self.config = CLDConfiguration(cloudName: "dggxoopi8", apiKey: "898787985328797")
        self.cloudinary = CLDCloudinary(configuration: config)
    }
    
    func uploadImage(data: Data) {
        let request = cloudinary.createUploader().upload(
            data: data, uploadPreset: "ebd8r09c") { progress in
                self.isUploading = true
                print("UPLOADING...")
            } completionHandler: { result, error in
                self.isUploading = false
                print("FINISHED!")
                if let safeResult = result {
                    let secureUrl = "https" + safeResult.url!.dropFirst(4)
                    self.imageUrl = URL(string: secureUrl)
                }
            }
        
        request.resume()
    }
}
