//
//  RoomFormView.swift
//  MC1-SpontanUhuy
//
//  Created by Sae Pasomba on 03/05/23.
//

import SwiftUI
import PhotosUI

struct RoomFormView: View {
    @StateObject var roomFormViewModel: RoomFormViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Text("\(roomFormViewModel.viewState == .newRoom ? "New" : "Edit") Room")
                    .fontWeight(.bold)
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                    
                    if roomFormViewModel.viewState == .editRoom {
                        ShareLink(item: URL(string: "https://google.com/")!) {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                }
            }
            .padding(.bottom)
            .font(.title3)
            
            
            Text("Input Your Room Name")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Your room name", text: $roomFormViewModel.roomNameField)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(hex: Constants.Color.primaryBlue), lineWidth: 1)
                }
            Text("Add Your Room Image")
                .frame(maxWidth: .infinity, alignment: .leading)
            PhotosPicker(selection: $roomFormViewModel.selectedItem, matching: .any(of: [.images, .not(.livePhotos)])) {
                //                if let selectedPhotoData = roomFormViewModel.selectedPhotoData {
                //                    if let image = UIImage(data: selectedPhotoData) {
                //                        VStack {
                //                            ZStack {
                //                                Image(uiImage: image)
                //                                    .resizable()
                //                                    .scaledToFit()
                //                                    .cornerRadius(15)
                //                                    .overlay {
                //                                        ZStack {
                //                                            RoundedRectangle(cornerRadius: 15)
                //                                                .stroke(Color(hex: Constants.Color.primaryBlue), lineWidth: 1)
                //                                            RoundedRectangle(cornerRadius: 15)
                //                                                .fill(Color(.black).opacity(0.4))
                //                                        }
                //                                    }
                //
                //                                Text("Edit Image")
                //                                    .foregroundColor(.white)
                //                            }
                //
                //                            Button {
                //                                withAnimation(Animation.easeIn(duration: 0.2)) {
                //                                    roomFormViewModel.selectedPhotoData = nil
                //                                }
                //                            } label: {
                //                                Text("Remove Image")
                //                                    .padding(.top)
                //                                    .foregroundColor(.red)
                //                            }
                //
                //                        }
                //                    }
                if let isUploadingStatus = roomFormViewModel.isUploading {
                    if isUploadingStatus {
                        ProgressView()
                        
                    } else {
                        AsyncImage(
                            url: roomFormViewModel.imageUrl,
                            content: { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(15)
                            },
                            placeholder: {
                                
                            }
                        )
                    }
                } else {
                    VStack {
                        Text("+")
                        Text("Add Image")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 125)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(hex: Constants.Color.primaryBlue), lineWidth: 1)
                    }
                }
            }
            .onChange(of: roomFormViewModel.selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        roomFormViewModel.selectedPhotoData = data
                        roomFormViewModel.uploadImage(data: data)
                    }
                }
            }
            
            Spacer()
            
            VStack {
                Spacer()
                
                NavigationLink {
                    Text("Hello")
                } label: {
                    Text("Save New Room")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background {
                            Color(hex: Constants.Color.primaryBlue)
                            
                        }
                        .cornerRadius(8)
                }
                
                if roomFormViewModel.viewState == .editRoom {
                    Button {
                        print("Hello")
                    } label: {
                        Text("Delete Room")
                            .foregroundColor(.red)
                            .padding(.vertical)
                    }
                }
                
            }
        }
        .padding(.horizontal)
        .foregroundColor(Color(hex: Constants.Color.primaryBlue))
    }
}

struct RoomFormView_Previews: PreviewProvider {
    static var previews: some View {
        RoomFormView(roomFormViewModel: RoomFormViewModel(viewState: .newRoom))
    }
}
