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
import CloudKit

enum RoomFormViewState {
    case newRoom
    case editRoom
}

class RoomFormViewModel: ObservableObject {
    @Published var viewState: RoomFormViewState
    @Published var room: RoomModel?
    @Published var name: String = ""
    @Published var imageURL: String? = nil
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedPhotoData: Data? = nil
    @Published var isLoading = false
    @Published var successAddRoom = false
    
    private let repository = FurnitureRepository()
    
    init(
        viewState: RoomFormViewState,
        room: RoomModel?,
        name: String = "",
        imageURL: String? = nil
    ) {
        self.viewState = viewState
        self.room = room
        self.name = name
        self.selectedItem = selectedItem
        self.imageURL = imageURL
    }
    
    func save() async {
        switch viewState {
        case .newRoom:
            DispatchQueue.main.async {
                self.isLoading = true
            }
            
            if let data = selectedPhotoData {
                await repository.insertRoom(name: name, imageData: data, completion: { results in
                    switch results {
                    case .success(_):
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.isLoading = false
                            self.successAddRoom = true
                        }
                    case .failure(_):
                        DispatchQueue.main.async {
                            self.isLoading = false
                        }
                    }
                })
            }
        case .editRoom:
            DispatchQueue.main.async {
                self.isLoading = true
            }
            
            if let id = room?.id {
                await repository.updateRoom(id: id, name: name, imageData: selectedPhotoData, completion: { results in
                    switch results {
                    case .success(_):
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.successAddRoom = true
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            print("Error: \(error)")
                            self.isLoading = false
                        }
                    }
                })
            }
        }
    }
    
    func delete(roomId: CKRecord.ID) async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        if let id = room?.id {
            do {
                let isSuccess = try await repository.deleteRoom(id: id)
                
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                
                switch isSuccess {
                case true:
                    DispatchQueue.main.async {
                        self.successAddRoom = true
                        self.isLoading = false
                    }
                case false:
                    DispatchQueue.main.async {
                        self.successAddRoom = false
                        self.isLoading = false
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}
